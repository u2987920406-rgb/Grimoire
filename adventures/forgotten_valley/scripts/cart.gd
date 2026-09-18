extends StaticBody3D

var wheel_attached: bool = false
var attached_wheel: Node = null

@onready var axle_anchor: Node3D = $AxleAnchor

func _ready() -> void:
	add_to_group("interactable")

func get_interaction_label(player: PlayerController) -> String:
	if player.held_object != null and player.held_object.has_method("is_cart_wheel"):
		return "Placer la roue"
	if wheel_attached:
		return "Pousser la charrette"
	return "Examiner la charrette"

func interact(player: PlayerController) -> void:
	if player.held_object != null and player.held_object.has_method("is_cart_wheel"):
		var wheel := player.take_held_object()
		wheel.call("attach_to", axle_anchor)
		attached_wheel = wheel
		wheel_attached = true
		player.show_message("La roue est remise sur l'axe.")
		return

	if wheel_attached and attached_wheel != null:
		var wheel := attached_wheel
		attached_wheel = null
		wheel_attached = false
		wheel.detach_from_cart(get_tree().current_scene, Vector3(1.6, 0.7, -0.3))
		player.show_message("CLONK ! La roue ressort de l'axe. Il manque quelque chose pour la retenir.")
		return

	player.show_message("L'axe est là, mais la roue n'y est plus.")
