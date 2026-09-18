extends CarryableBody

var attached_to_cart: bool = false

func _ready() -> void:
	interaction_name = "Roue"
	super._ready()

func is_cart_wheel() -> bool:
	return true

func attach_to(anchor: Node3D) -> void:
	attached_to_cart = true
	set_held(true)
	reparent(anchor, false)
	transform = Transform3D.IDENTITY
	rotation_degrees = Vector3(90, 0, 0)

func detach_from_cart(world_parent: Node, impulse: Vector3) -> void:
	var world_transform := global_transform
	reparent(world_parent, false)
	global_transform = world_transform
	attached_to_cart = false
	set_held(false)
	apply_central_impulse(impulse)
