extends Node3D

@onready var player: PlayerController = $Player
@onready var prompt_label: Label = $UI/PromptLabel
@onready var message_panel: PanelContainer = $UI/MessagePanel
@onready var message_label: Label = $UI/MessagePanel/Margin/MessageLabel
@onready var inspection_panel: PanelContainer = $UI/InspectionPanel
@onready var inspection_title: Label = $UI/InspectionPanel/Margin/VBox/Title
@onready var inspection_detail: Label = $UI/InspectionPanel/Margin/VBox/Detail

func _ready() -> void:
	player.prompt_changed.connect(_on_prompt_changed)
	player.message_requested.connect(_on_message_requested)
	player.inspection_requested.connect(_on_inspection_requested)
	message_panel.visible = false
	inspection_panel.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if inspection_panel.visible and (event.is_action_pressed("ui_cancel") or event.is_action_pressed("interact")):
		inspection_panel.visible = false
		player.controls_enabled = true
		get_viewport().set_input_as_handled()
		return

	if message_panel.visible and (event.is_action_pressed("ui_cancel") or event.is_action_pressed("interact")):
		message_panel.visible = false
		get_viewport().set_input_as_handled()

func _on_prompt_changed(text: String) -> void:
	prompt_label.text = text

func _on_message_requested(text: String) -> void:
	message_label.text = text
	message_panel.visible = true

func _on_inspection_requested(title: String, detail: String) -> void:
	inspection_title.text = title
	inspection_detail.text = detail
	inspection_panel.visible = true
	message_panel.visible = false
	player.controls_enabled = false
