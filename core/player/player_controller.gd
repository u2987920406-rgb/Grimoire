class_name PlayerController
extends CharacterBody3D

signal prompt_changed(text: String)
signal message_requested(text: String)
signal inspection_requested(title: String, detail: String)

@export var move_speed: float = 4.0
@export var acceleration: float = 14.0
@export var gravity: float = 18.0
@export var throw_impulse: float = 4.5

@onready var interaction_area: Area3D = $InteractionArea
@onready var hold_anchor: Marker3D = $HoldAnchor

var held_object: CarryableBody = null
var controls_enabled: bool = true
var _current_target: Node = null

func _physics_process(delta: float) -> void:
	_update_interaction_target()

	if not controls_enabled:
		velocity.x = move_toward(velocity.x, 0.0, acceleration * delta)
		velocity.z = move_toward(velocity.z, 0.0, acceleration * delta)
		move_and_slide()
		return

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

func _unhandled_input(event: InputEvent) -> void:
	if not controls_enabled:
		return

	if event.is_action_pressed("interact") and _current_target != null:
		if _current_target.has_method("interact"):
			_current_target.call("interact", self)
			get_viewport().set_input_as_handled()
			return

	if event.is_action_pressed("drop_object") and held_object != null:
		drop_held()
		get_viewport().set_input_as_handled()
		return

	if event.is_action_pressed("throw_object") and held_object != null:
		throw_held()
		get_viewport().set_input_as_handled()

func _update_interaction_target() -> void:
	var nearest: Node = null
	var nearest_distance := INF

	for body in interaction_area.get_overlapping_bodies():
		if body == self or not body.is_in_group("interactable"):
			continue
		if body == held_object:
			continue
		var distance := global_position.distance_squared_to(body.global_position)
		if distance < nearest_distance:
			nearest = body
			nearest_distance = distance

	_current_target = nearest

	var parts: Array[String] = []
	if _current_target != null and _current_target.has_method("get_interaction_label"):
		parts.append("E  " + str(_current_target.call("get_interaction_label", self)))
	if held_object != null:
		parts.append("Q  Poser")
		parts.append("F  Lancer")
	prompt_changed.emit("   •   ".join(parts))

func pick_up(object: CarryableBody) -> void:
	if held_object != null:
		return
	held_object = object
	object.on_picked_up()
	object.reparent(hold_anchor, false)
	object.transform = Transform3D.IDENTITY

func take_held_object() -> CarryableBody:
	if held_object == null:
		return null
	var object := held_object
	held_object = null
	return object

func drop_held() -> void:
	var object := take_held_object()
	if object == null:
		return
	var world_transform := object.global_transform
	object.reparent(get_tree().current_scene, false)
	object.global_transform = world_transform
	object.global_position += -global_transform.basis.z * 0.8
	object.on_dropped()

func throw_held() -> void:
	var object := take_held_object()
	if object == null:
		return
	var world_transform := object.global_transform
	object.reparent(get_tree().current_scene, false)
	object.global_transform = world_transform
	var direction := (-global_transform.basis.z + Vector3.UP * 0.28).normalized() * throw_impulse
	object.on_thrown(direction)

func show_message(text: String) -> void:
	message_requested.emit(text)

func start_inspection(title: String, detail: String) -> void:
	inspection_requested.emit(title, detail)
