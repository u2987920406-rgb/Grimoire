extends CarryableBody

var in_water: bool = false

func _ready() -> void:
	interaction_name = "Pomme"
	importance = CarryableBody.Importance.NON_CRITICAL
	super._ready()

func set_in_water(value: bool) -> void:
	in_water = value
	if is_held:
		return
	gravity_scale = 0.18 if value else 1.0
	if value:
		linear_damp = 2.6
	else:
		linear_damp = 0.1

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if not in_water or is_held:
		return
	var velocity := state.linear_velocity
	velocity.y = move_toward(velocity.y, 0.12, 3.5 * state.step)
	velocity.x = move_toward(velocity.x, 0.75, 1.8 * state.step)
	velocity.z = move_toward(velocity.z, 0.0, 1.8 * state.step)
	state.linear_velocity = velocity

func on_picked_up() -> void:
	in_water = false
	gravity_scale = 1.0
	linear_damp = 0.1
	super.on_picked_up()
