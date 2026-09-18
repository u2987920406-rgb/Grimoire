class_name PlayerController
extends CharacterBody3D

@export var move_speed: float = 4.0
@export var acceleration: float = 14.0
@export var gravity: float = 18.0

func _physics_process(delta: float) -> void:
	var input_vector := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var desired_direction := Vector3(input_vector.x, 0.0, input_vector.y)
	
	if desired_direction.length_squared() > 1.0:
		desired_direction = desired_direction.normalized()
	
	var target_velocity := desired_direction * move_speed
	velocity.x = move_toward(velocity.x, target_velocity.x, acceleration * delta)
	velocity.z = move_toward(velocity.z, target_velocity.z, acceleration * delta)
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0.0
	
	if desired_direction.length_squared() > 0.001:
		var target_yaw := atan2(desired_direction.x, desired_direction.z)
		rotation.y = lerp_angle(rotation.y, target_yaw, minf(1.0, 10.0 * delta))
	
	move_and_slide()
