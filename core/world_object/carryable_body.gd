class_name CarryableBody
extends RigidBody3D

enum Importance {
	NON_CRITICAL,
	RECOVERABLE,
	CRITICAL,
}

@export var interaction_name: String = "Objet"
@export var importance: Importance = Importance.NON_CRITICAL
@export var recovery_radius: float = 18.0
@export var recovery_min_y: float = -2.5

var is_held: bool = false
var _saved_collision_layer: int
var _saved_collision_mask: int
var _recovery_transform: Transform3D

func _ready() -> void:
	add_to_group("interactable")
	_saved_collision_layer = collision_layer
	_saved_collision_mask = collision_mask
	_recovery_transform = global_transform

func _physics_process(_delta: float) -> void:
	if is_held or importance == Importance.NON_CRITICAL:
		return

	var origin := _recovery_transform.origin
	var horizontal_distance := Vector2(
		global_position.x - origin.x,
		global_position.z - origin.z
	).length()

	if global_position.y < recovery_min_y or horizontal_distance > recovery_radius:
		recover_to_safe_position()

func get_interaction_label(_player: PlayerController) -> String:
	return "Prendre " + interaction_name.to_lower()

func interact(player: PlayerController) -> void:
	if not is_held:
		player.pick_up(self)

func set_held(value: bool) -> void:
	is_held = value
	freeze = value
	if value:
		collision_layer = 0
		collision_mask = 0
		linear_velocity = Vector3.ZERO
		angular_velocity = Vector3.ZERO
	else:
		collision_layer = _saved_collision_layer
		collision_mask = _saved_collision_mask

func remember_safe_position() -> void:
	_recovery_transform = global_transform

func recover_to_safe_position() -> void:
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	global_transform = _recovery_transform
	sleeping = true

func on_picked_up() -> void:
	set_held(true)

func on_dropped() -> void:
	set_held(false)

func on_thrown(direction: Vector3) -> void:
	set_held(false)
	apply_central_impulse(direction)
