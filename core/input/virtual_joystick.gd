class_name GrimoireVirtualJoystick
extends Control

signal direction_changed(direction: Vector2)

@export var radius: float = 70.0
@export var knob_radius: float = 28.0

var _pointer_id: int = -1
var _direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	set_process_unhandled_input(false)
	queue_redraw()

func _gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		var touch := event as InputEventScreenTouch
		if touch.pressed and _pointer_id == -1:
			_pointer_id = touch.index
			_update_direction(touch.position)
			accept_event()
		elif not touch.pressed and touch.index == _pointer_id:
			_pointer_id = -1
			_set_direction(Vector2.ZERO)
			accept_event()
	elif event is InputEventScreenDrag:
		var drag := event as InputEventScreenDrag
		if drag.index == _pointer_id:
			_update_direction(drag.position)
			accept_event()
	elif event is InputEventMouseButton:
		var mouse_button := event as InputEventMouseButton
		if mouse_button.button_index == MOUSE_BUTTON_LEFT:
			if mouse_button.pressed:
				_pointer_id = -2
				_update_direction(mouse_button.position)
			elif _pointer_id == -2:
				_pointer_id = -1
				_set_direction(Vector2.ZERO)
			accept_event()
	elif event is InputEventMouseMotion and _pointer_id == -2:
		_update_direction((event as InputEventMouseMotion).position)
		accept_event()

func _update_direction(local_position: Vector2) -> void:
	var center := size * 0.5
	var offset := local_position - center
	var clamped := offset.limit_length(radius)
	_set_direction(clamped / radius)

func _set_direction(value: Vector2) -> void:
	_direction = value.limit_length(1.0)
	direction_changed.emit(_direction)
	queue_redraw()

func _draw() -> void:
	var center := size * 0.5
	draw_circle(center, radius, Color(0.08, 0.08, 0.08, 0.22))
	draw_circle(center, radius - 3.0, Color(1, 1, 1, 0.12), false, 3.0)
	var knob_position := center + _direction * radius
	draw_circle(knob_position, knob_radius, Color(1, 1, 1, 0.45))
	draw_circle(knob_position, knob_radius - 3.0, Color(1, 1, 1, 0.18), false, 3.0)
