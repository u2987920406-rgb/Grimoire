class_name CarryableBody
extends RigidBody3D

@export var interaction_name: String = "Objet"
var is_held: bool = false
var _saved_collision_layer: int
var _saved_collision_mask: int

func _ready() -> void:
	add_to_group("interactable")
	_saved_collision_layer = collision_layer
	_saved_collision_mask = collision_mask

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

func on_picked_up() -> void:
	set_held(true)

func on_dropped() -> void:
	set_held(false)

func on_thrown(direction: Vector3) -> void:
	set_held(false)
	apply_central_impulse(direction)
