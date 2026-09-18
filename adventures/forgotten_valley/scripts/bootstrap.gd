extends Node3D

@onready var player: PlayerController = $Player
@onready var prompt_label: Label = $UI/PromptLabel
@onready var message_panel: PanelContainer = $UI/MessagePanel
@onready var message_label: Label = $UI/MessagePanel/Margin/MessageLabel
@onready var inspection_panel: PanelContainer = $UI/InspectionPanel
@onready var inspection_title: Label = $UI/InspectionPanel/Margin/VBox/Title
@onready var inspection_detail: Label = $UI/InspectionPanel/Margin/VBox/Detail
@onready var touch_controls: Control = $UI/TouchControls
@onready var joystick: VirtualJoystick = $UI/TouchControls/VirtualJoystick
@onready var interact_button: Button = $UI/TouchControls/InteractButton
@onready var drop_button: Button = $UI/TouchControls/DropButton
@onready var throw_button: Button = $UI/TouchControls/ThrowButton
@onready var close_button: Button = $UI/CloseButton
@onready var help_label: Label = $UI/HelpLabel

func _ready() -> void:
	player.prompt_changed.connect(_on_prompt_changed)
	player.message_requested.connect(_on_message_requested)
	player.inspection_requested.connect(_on_inspection_requested)

	joystick.direction_changed.connect(player.set_touch_move_input)
	interact_button.pressed.connect(player.request_interact)
	drop_button.pressed.connect(player.request_drop)
	throw_button.pressed.connect(player.request_throw)
	close_button.pressed.connect(_close_overlay)

	message_panel.visible = false
	inspection_panel.visible = false
	close_button.visible = false

	touch_controls.visible = DisplayServer.is_touchscreen_available()
	if touch_controls.visible:
		help_label.text = "GRAYBOX — La Vallée oubliée\nJoystick : déplacer • boutons : agir"
	else:
		help_label.text = "GRAYBOX — La Vallée oubliée\nWASD déplacer • E interagir • Q poser • F lancer"
	_update_touch_action_visibility()

func _process(_delta: float) -> void:
	_update_touch_action_visibility()

func _unhandled_input(event: InputEvent) -> void:
	if inspection_panel.visible and (event.is_action_pressed("ui_cancel") or event.is_action_pressed("interact")):
		_close_overlay()
		get_viewport().set_input_as_handled()
		return

	if message_panel.visible and (event.is_action_pressed("ui_cancel") or event.is_action_pressed("interact")):
		_close_overlay()
		get_viewport().set_input_as_handled()

func _on_prompt_changed(text: String) -> void:
	if touch_controls.visible:
		prompt_label.text = text
	else:
		prompt_label.text = ("E  " + text) if not text.is_empty() else ""
	interact_button.disabled = text.is_empty()

func _on_message_requested(text: String) -> void:
	message_label.text = text
	message_panel.visible = true
	close_button.visible = touch_controls.visible

func _on_inspection_requested(title: String, detail: String) -> void:
	inspection_title.text = title
	inspection_detail.text = detail
	inspection_panel.visible = true
	message_panel.visible = false
	player.controls_enabled = false
	close_button.visible = touch_controls.visible

func _close_overlay() -> void:
	inspection_panel.visible = false
	message_panel.visible = false
	close_button.visible = false
	player.controls_enabled = true

func _update_touch_action_visibility() -> void:
	if not touch_controls.visible:
		return
	var holding := player.has_held_object()
	drop_button.visible = holding
	throw_button.visible = holding
