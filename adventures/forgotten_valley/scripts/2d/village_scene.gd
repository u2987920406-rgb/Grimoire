extends Node2D

@onready var player: Sprite2D = $World/Player
@onready var message_panel: PanelContainer = $UI/MessagePanel
@onready var message_label: Label = $UI/MessagePanel/Margin/Message
@onready var scene_title: Label = $UI/SceneTitle

var target_position: Vector2
var moving := false
const WALK_SPEED := 330.0
const WALK_MIN_Y := 430.0
const WALK_MAX_Y := 650.0

func _ready() -> void:
	target_position = player.position
	message_panel.visible = false
	for hotspot in get_tree().get_nodes_in_group("hotspot_2d"):
		hotspot.activated.connect(_on_hotspot_activated)
	scene_title.text = "La Vallée oubliée — Village"

func _process(delta: float) -> void:
	if moving:
		player.position = player.position.move_toward(target_position, WALK_SPEED * delta)
		var scale_factor := remap(player.position.y, WALK_MIN_Y, WALK_MAX_Y, 0.72, 1.0)
		player.scale = Vector2.ONE * scale_factor
		if player.position.distance_to(target_position) < 4.0:
			moving = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_set_walk_target(event.position)
	elif event is InputEventScreenTouch and event.pressed:
		_set_walk_target(event.position)

func _set_walk_target(pos: Vector2) -> void:
	if pos.y < WALK_MIN_Y or pos.y > WALK_MAX_Y:
		return
	target_position = Vector2(clampf(pos.x, 70.0, 1210.0), clampf(pos.y, WALK_MIN_Y, WALK_MAX_Y))
	moving = true

func _on_hotspot_activated(hotspot_id: String) -> void:
	match hotspot_id:
		"mill":
			_show_message("Le moulin domine le canal. Sa grande roue semble liée au débit de l'eau.")
		"bridge":
			_show_message("Le pont de pierre relie les deux rives. Le chemin continue vers le village.")
		"ruins":
			_show_message("Les ruines veillent au-dessus de la vallée. Elles semblent reliées aux anciennes bornes solaires.")
		"house":
			_show_message("Une maison du village. Des outils et des traces de travail montrent qu'elle est encore habitée.")

func _show_message(text: String) -> void:
	message_label.text = text
	message_panel.visible = true
	get_tree().create_timer(4.0).timeout.connect(func(): message_panel.visible = false)
