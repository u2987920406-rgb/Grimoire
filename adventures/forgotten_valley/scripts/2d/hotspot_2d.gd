class_name AdventureHotspot2D
extends Area2D

signal activated(hotspot_id: String)

@export var hotspot_id: String = ""
@export var label: String = "Examiner"
@export_multiline var message: String = ""

func _ready() -> void:
	input_event.connect(_on_input_event)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		activated.emit(hotspot_id)
		get_viewport().set_input_as_handled()
	elif event is InputEventScreenTouch and event.pressed:
		activated.emit(hotspot_id)
		get_viewport().set_input_as_handled()
