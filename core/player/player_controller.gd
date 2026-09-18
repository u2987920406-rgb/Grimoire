class_name PlayerController
extends CharacterBody3D

signal prompt_changed(text: String)
signal message_requested(text: String)
signal inspection_requested(title: String, detail: String)

@export var move_speed: float = 4.0
@export var acceleration: float = 14.0
@export var gravity: float = 18.0
@export var throw_impulse: float = 4.5
@export var camera_yaw_speed: float = 2.2
@export var camera_pitch_speed: float = 1.4
@export var camera_min_pitch_degrees: float = -58.0
@export var camera_max_pitch_degrees: float = -22.0

@onready var interaction_area: Area3D = $InteractionArea
@onready var hold_anchor: Marker3D = $HoldAnchor
@onready var camera_rig: Node3D = $"../CameraRig"

var held_object: CarryableBody = null
var controls_enabled: bool = true
var touch_move_input: Vector2 = Vector2.ZERO
var touch_look_input: Vector2 = Vector2.ZERO
var _current_target: Node = null
var _camera_yaw: float = 0.0
var _camera_pitch: float = deg_to_rad(-34.0)

func _ready() -> void:
	_camera_yaw = camera_rig.rotation.y
	_camera_pitch = camera_rig.rotation.x

func _physics_process(delta: float) -> void:
	_update_camera(delta)
	_update_interaction_target()

	if not controls_enabled:
		velocity.x = move_toward(velocity.x, 0.0, acceleration * delta)
		velocity.z = move_toward(velocity.z, 0.0, acceleration * delta)
		move_and_slide()
		return

	var keyboard_input := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var input_vector := keyboard_input + touch_move_input
	if input_vector.length_squared() > 1.0:
		input_vector = input_vector.normalized()

	var camera_forward := -camera_rig.global_transform.basis.z
	camera_forward.y = 0.0
	camera_forward = camera_forward.normalized()
	var camera_right := camera_rig.global_transform.basis.x
	camera_right.y = 0.0
	camera_right = camera_right.normalized()

	var desired_direction := camera_right * input_vector.x + camera_forward * -input_vector.y
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

	if event.is_action_pressed("interact"):
		request_interact()
		get_viewport().set_input_as_handled()
		return

	if event.is_action_pressed("drop_object"):
		request_drop()
		get_viewport().set_input_as_handled()
		return

	if event.is_action_pressed("throw_object"):
		request_throw()
		get_viewport().set_input_as_handled()

func _update_camera(delta: float) -> void:
	camera_rig.global_position = global_position + Vector3(0.0, 0.9, 0.0)

	if not controls_enabled:
		return

	_camera_yaw -= touch_look_input.x * camera_yaw_speed * delta
	_camera_pitch -= touch_look_input.y * camera_pitch_speed * delta
	_camera_pitch = clamp(
		_camera_pitch,
		deg_to_rad(camera_min_pitch_degrees),
		deg_to_rad(camera_max_pitch_degrees)
	)

	camera_rig.rotation = Vector3(_camera_pitch, _camera_yaw, 0.0)

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

	var interaction_label := ""
	if _current_target != null and _current_target.has_method("get_interaction_label"):
		interaction_label = str(_current_target.call("get_interaction_label", self))
	prompt_changed.emit(interaction_label)

func set_touch_move_input(value: Vector2) -> void:
	touch_move_input = value.limit_length(1.0)

func set_touch_look_input(value: Vector2) -> void:
	touch_look_input = value.limit_length(1.0)

func request_interact() -> void:
	if not controls_enabled or _current_target == null:
		return
	if _current_target.has_method("interact"):
		_current_target.call("interact", self)

func request_drop() -> void:
	if not controls_enabled or held_object == null:
		return
	drop_held()

func request_throw() -> void:
	if not controls_enabled or held_object == null:
		return
	throw_held()

func has_held_object() -> bool:
	return held_object != null

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
