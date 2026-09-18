extends Node3D

@onready var player: PlayerController = $Player
@onready var camera: Camera3D = $CameraRig/CameraPitch/Camera3D
@onready var prompt_label: Label = $UI/PromptLabel
@onready var context_bubble: PanelContainer = $UI/ContextBubble
@onready var context_bubble_label: Label = $UI/ContextBubble/Margin/Label
@onready var message_panel: PanelContainer = $UI/MessagePanel
@onready var message_label: Label = $UI/MessagePanel/Margin/MessageLabel
@onready var inspection_panel: PanelContainer = $UI/InspectionPanel
@onready var inspection_title: Label = $UI/InspectionPanel/Margin/VBox/Title
@onready var inspection_detail: Label = $UI/InspectionPanel/Margin/VBox/Detail
@onready var touch_controls: Control = $UI/TouchControls
@onready var move_joystick: GrimoireVirtualJoystick = $UI/TouchControls/MoveJoystick
@onready var look_joystick: GrimoireVirtualJoystick = $UI/TouchControls/LookJoystick
@onready var interact_button: Button = $UI/TouchControls/InteractButton
@onready var drop_button: Button = $UI/TouchControls/DropButton
@onready var throw_button: Button = $UI/TouchControls/ThrowButton
@onready var close_button: Button = $UI/CloseButton
@onready var help_label: Label = $UI/HelpLabel

var _current_interaction_text: String = ""

func _ready() -> void:
	player.prompt_changed.connect(_on_prompt_changed)
	player.message_requested.connect(_on_message_requested)
	player.inspection_requested.connect(_on_inspection_requested)

	move_joystick.direction_changed.connect(player.set_touch_move_input)
	look_joystick.direction_changed.connect(player.set_touch_look_input)
	interact_button.pressed.connect(player.request_interact)
	drop_button.pressed.connect(player.request_drop)
	throw_button.pressed.connect(player.request_throw)
	close_button.pressed.connect(_close_overlay)

	message_panel.visible = false
	inspection_panel.visible = false
	close_button.visible = false
	context_bubble.visible = false

	touch_controls.visible = DisplayServer.is_touchscreen_available()
	if touch_controls.visible:
		help_label.text = "GRAYBOX — La Vallée oubliée\nJoystick gauche : déplacer • droit : caméra"
		prompt_label.visible = false
	else:
		help_label.text = "GRAYBOX — La Vallée oubliée\nWASD déplacer • E interagir • Q poser • F lancer"
		prompt_label.visible = true
	_update_touch_action_visibility()

func _process(_delta: float) -> void:
	_update_touch_action_visibility()
	_update_context_bubble_position()

func _unhandled_input(event: InputEvent) -> void:
	if inspection_panel.visible and (event.is_action_pressed("ui_cancel") or event.is_action_pressed("interact")):
		_close_overlay()
		get_viewport().set_input_as_handled()
		return

	if message_panel.visible and (event.is_action_pressed("ui_cancel") or event.is_action_pressed("interact")):
		_close_overlay()
		get_viewport().set_input_as_handled()

func _on_prompt_changed(text: String) -> void:
	_current_interaction_text = text
	interact_button.disabled = text.is_empty()

	if touch_controls.visible:
		context_bubble_label.text = text
		context_bubble.visible = not text.is_empty() and not _overlay_is_open()
		interact_button.text = text if not text.is_empty() else "Interagir"
	else:
		prompt_label.text = ("E  " + text) if not text.is_empty() else ""

func _on_message_requested(text: String) -> void:
	message_label.text = text
	message_panel.visible = true
	context_bubble.visible = false
	close_button.visible = touch_controls.visible

func _on_inspection_requested(title: String, detail: String) -> void:
	inspection_title.text = title
	inspection_detail.text = detail
	inspection_panel.visible = true
	message_panel.visible = false
	context_bubble.visible = false
	player.controls_enabled = false
	close_button.visible = touch_controls.visible

func _close_overlay() -> void:
	inspection_panel.visible = false
	message_panel.visible = false
	close_button.visible = false
	player.controls_enabled = true
	if touch_controls.visible and not _current_interaction_text.is_empty():
		context_bubble.visible = true

func _update_touch_action_visibility() -> void:
	if not touch_controls.visible:
		return
	var holding := player.has_held_object()
	drop_button.visible = holding
	throw_button.visible = holding

func _update_context_bubble_position() -> void:
	if not touch_controls.visible or not context_bubble.visible:
		return

	var world_anchor := player.global_position + Vector3(0.0, 2.15, 0.0)
	var screen_position := camera.unproject_position(world_anchor)
	var viewport_size := get_viewport().get_visible_rect().size

	context_bubble.reset_size()
	var bubble_size := context_bubble.size
	var desired_position := screen_position - Vector2(bubble_size.x * 0.5, bubble_size.y + 18.0)

	desired_position.x = clamp(desired_position.x, 18.0, viewport_size.x - bubble_size.x - 18.0)
	desired_position.y = clamp(desired_position.y, 90.0, viewport_size.y - bubble_size.y - 250.0)

	context_bubble.position = desired_position

func _overlay_is_open() -> bool:
	return message_panel.visible or inspection_panel.visible
