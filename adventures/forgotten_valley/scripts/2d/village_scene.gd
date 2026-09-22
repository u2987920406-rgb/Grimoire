extends Node2D

@onready var player: Sprite2D = $World/Player
@onready var message_panel: PanelContainer = $UI/MessagePanel
@onready var message_label: Label = $UI/MessagePanel/Margin/Message
@onready var scene_title: Label = $UI/SceneTitle

const WALK_SPEED := 330.0
const WALK_MIN_Y := 420.0
const WALK_MAX_Y := 650.0

# La rivière occupe la partie basse-droite du tableau. Elle est bloquante :
# on la traverse uniquement par le pont.
var WATER_POLYGON := PackedVector2Array([
	Vector2(555, 470),
	Vector2(650, 450),
	Vector2(760, 465),
	Vector2(850, 500),
	Vector2(980, 545),
	Vector2(1100, 520),
	Vector2(1280, 555),
	Vector2(1280, 720),
	Vector2(760, 720),
	Vector2(695, 625),
	Vector2(620, 565)
])

# Corridor jouable du pont.
var BRIDGE_POLYGON := PackedVector2Array([
	Vector2(675, 555),
	Vector2(700, 495),
	Vector2(780, 445),
	Vector2(875, 430),
	Vector2(975, 485),
	Vector2(995, 545),
	Vector2(930, 525),
	Vector2(835, 475),
	Vector2(755, 485),
	Vector2(705, 555)
])

# Petite zone de rive opposée accessible après le pont.
var NORTH_BANK_POLYGON := PackedVector2Array([
	Vector2(760, 420),
	Vector2(1210, 420),
	Vector2(1210, 535),
	Vector2(995, 535),
	Vector2(930, 490),
	Vector2(835, 455),
	Vector2(760, 475)
])

var target_position: Vector2
var moving := false
var _route: Array[Vector2] = []

func _ready() -> void:
	target_position = player.position
	message_panel.visible = false
	for hotspot in get_tree().get_nodes_in_group("hotspot_2d"):
		hotspot.activated.connect(_on_hotspot_activated)
	scene_title.text = "La Vallée oubliée — Village"

func _process(delta: float) -> void:
	if not moving:
		return

	player.position = player.position.move_toward(target_position, WALK_SPEED * delta)
	var scale_factor := remap(clampf(player.position.y, WALK_MIN_Y, WALK_MAX_Y), WALK_MIN_Y, WALK_MAX_Y, 0.72, 1.0)
	player.scale = Vector2.ONE * scale_factor

	if player.position.distance_to(target_position) < 4.0:
		player.position = target_position
		if _route.is_empty():
			moving = false
		else:
			target_position = _route.pop_front()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_set_walk_target(event.position)
	elif event is InputEventScreenTouch and event.pressed:
		_set_walk_target(event.position)

func _set_walk_target(pos: Vector2) -> void:
	var clamped := Vector2(clampf(pos.x, 50.0, 1230.0), clampf(pos.y, WALK_MIN_Y, WALK_MAX_Y))

	if _is_water_only(clamped):
		_show_message("L'eau est trop profonde ici. Il faut utiliser le pont.")
		return

	if not _is_walkable(clamped):
		return

	_route = _plan_route(player.position, clamped)
	if _route.is_empty():
		target_position = clamped
	else:
		target_position = _route.pop_front()
	moving = true

func _is_walkable(pos: Vector2) -> bool:
	if pos.y < WALK_MIN_Y or pos.y > WALK_MAX_Y:
		return false
	if Geometry2D.is_point_in_polygon(pos, BRIDGE_POLYGON):
		return true
	if Geometry2D.is_point_in_polygon(pos, NORTH_BANK_POLYGON):
		return true
	return not Geometry2D.is_point_in_polygon(pos, WATER_POLYGON)

func _is_water_only(pos: Vector2) -> bool:
	return Geometry2D.is_point_in_polygon(pos, WATER_POLYGON) and not Geometry2D.is_point_in_polygon(pos, BRIDGE_POLYGON)

func _is_north_side(pos: Vector2) -> bool:
	return Geometry2D.is_point_in_polygon(pos, NORTH_BANK_POLYGON) or (pos.y < 500.0 and pos.x > 760.0)

func _plan_route(from: Vector2, to: Vector2) -> Array[Vector2]:
	var from_north := _is_north_side(from)
	var to_north := _is_north_side(to)
	if from_north == to_north:
		return [to]

	# Le personnage suit réellement le tablier du pont au lieu de couper dans l'eau.
	var south_entry := Vector2(690, 555)
	var bridge_mid_1 := Vector2(760, 490)
	var bridge_mid_2 := Vector2(855, 455)
	var north_exit := Vector2(965, 500)

	if to_north:
		return [south_entry, bridge_mid_1, bridge_mid_2, north_exit, to]
	return [north_exit, bridge_mid_2, bridge_mid_1, south_entry, to]

func _on_hotspot_activated(hotspot_id: String) -> void:
	match hotspot_id:
		"mill":
			_show_message("Le moulin domine le canal. Sa grande roue semble liée au débit de l'eau.")
		"bridge":
			_show_message("Le pont de pierre est le passage sûr pour rejoindre l'autre rive.")
		"ruins":
			_show_message("Les ruines veillent au-dessus de la vallée. Elles semblent reliées aux anciennes bornes solaires.")
		"house":
			_show_message("Une maison du village. Des outils et des traces de travail montrent qu'elle est encore habitée.")

func _show_message(text: String) -> void:
	message_label.text = text
	message_panel.visible = true
	get_tree().create_timer(4.0).timeout.connect(func(): message_panel.visible = false)
