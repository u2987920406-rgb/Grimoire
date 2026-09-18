extends StaticBody3D

@export var push_distance: float = 1.4
@export var push_duration: float = 0.55
@export var push_side_min_z: float = 0.55
@export var push_side_max_x: float = 1.9

var wheel_attached: bool = false
var attached_wheel: Node = null
var wheel_reattached_once: bool = false
var wheel_failed_once: bool = false
var wheel_retained: bool = false
var cart_repaired: bool = false
var push_in_progress: bool = false
var attached_retainer: Node = null

@onready var axle_anchor: Node3D = $AxleAnchor
@onready var retainer_anchor: Node3D = $RetainerAnchor

func _ready() -> void:
	add_to_group("interactable")

func get_interaction_label(player: PlayerController) -> String:
	if push_in_progress:
		return ""

	if player.held_object != null and player.held_object.has_method("is_cart_wheel"):
		return "Placer la roue"

	if wheel_attached and not wheel_retained and player.held_object != null and player.held_object.has_method("is_axle_retainer"):
		return "Insérer la cheville"

	if wheel_attached:
		if _is_player_in_push_position(player):
			return "Pousser"
		return "Examiner la charrette"

	return "Examiner la charrette"

func interact(player: PlayerController) -> void:
	if push_in_progress:
		return

	if player.held_object != null and player.held_object.has_method("is_cart_wheel"):
		_attach_wheel(player)
		return

	if wheel_attached and not wheel_retained and player.held_object != null and player.held_object.has_method("is_axle_retainer"):
		_install_retainer(player)
		return

	if wheel_attached and attached_wheel != null:
		if _is_player_in_push_position(player):
			_push_cart(player)
		else:
			_examine_cart(player)
		return

	_examine_cart(player)

func _attach_wheel(player: PlayerController) -> void:
	var wheel := player.take_held_object()
	wheel.call("attach_to", axle_anchor)
	attached_wheel = wheel
	wheel_attached = true
	wheel_reattached_once = true
	player.show_message("La roue est remise sur l'axe.")

func _install_retainer(player: PlayerController) -> void:
	var retainer := player.take_held_object()
	retainer.set_held(true)
	retainer.reparent(retainer_anchor, false)
	retainer.transform = Transform3D.IDENTITY
	retainer.remember_safe_position()
	attached_retainer = retainer
	wheel_retained = true
	player.show_message("La cheville traverse le trou au bout de l'axe. La roue ne peut plus ressortir aussi facilement.")

func _examine_cart(player: PlayerController) -> void:
	if wheel_attached and wheel_retained:
		player.show_message("La roue est en place et la cheville la retient sur l'axe.")
	elif wheel_attached:
		player.show_message("La roue est sur l'axe. Au bout, un petit trou traverse l'axe : quelque chose pourrait la retenir.")
	elif wheel_failed_once:
		player.show_message("La roue est retombée. Au bout de l'axe, un petit trou semble prévu pour une pièce de retenue.")
	else:
		player.show_message("La roue n'est plus sur l'axe.")

func _is_player_in_push_position(player: PlayerController) -> bool:
	var local_player := to_local(player.global_position)
	return local_player.z >= push_side_min_z and absf(local_player.x) <= push_side_max_x

func _push_cart(player: PlayerController) -> void:
	push_in_progress = true
	player.controls_enabled = false

	var push_direction := -global_basis.z.normalized()
	var distance := push_distance * (1.6 if wheel_retained else 1.0)
	var target_position := global_position + push_direction * distance

	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "global_position", target_position, push_duration)
	await tween.finished

	if wheel_retained:
		cart_repaired = true
		player.show_message("La charrette roule et la roue tient. Cette fois, la réparation fonctionne.")
	else:
		_fail_wheel_after_push(player)

	player.controls_enabled = true
	push_in_progress = false

func _fail_wheel_after_push(player: PlayerController) -> void:
	if attached_wheel == null:
		return

	var wheel := attached_wheel
	attached_wheel = null
	wheel_attached = false
	wheel_failed_once = true

	var release_direction := (global_basis.x + Vector3.UP * 0.45).normalized() * 1.7
	wheel.call("detach_from_cart", get_tree().current_scene, release_direction)
	player.show_message("CLONK ! La roue ressort de l'axe. Il manque quelque chose pour la retenir.")
