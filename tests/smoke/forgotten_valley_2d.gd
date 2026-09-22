extends SceneTree

func _initialize() -> void:
	call_deferred("_run")

func _fail(message: String) -> void:
	push_error("2D SMOKE FAILED: " + message)
	quit(1)

func _check(condition: bool, message: String) -> bool:
	if not condition:
		_fail(message)
		return false
	return true

func _simulate(scene: Node, frames: int) -> void:
	for _i in range(frames):
		scene.call("_process", 1.0 / 60.0)

func _run() -> void:
	var packed := load("res://adventures/forgotten_valley/scenes/village_2d.tscn") as PackedScene
	if not _check(packed != null, "village_2d scene must load"):
		return
	var scene := packed.instantiate()
	root.add_child(scene)
	await process_frame

	var player := scene.get_node_or_null("World/Player") as Sprite2D
	if not _check(player != null, "2D player missing"):
		return
	if not _check(scene.get_node_or_null("World/MillHotspot") != null, "mill hotspot missing"):
		return
	if not _check(scene.get_node_or_null("World/BridgeHotspot") != null, "bridge hotspot missing"):
		return
	if not _check(scene.get_node_or_null("World/RuinsHotspot") != null, "ruins hotspot missing"):
		return
	if not _check(scene.get_node_or_null("World/HouseHotspot") != null, "house hotspot missing"):
		return

	# Land movement.
	var initial := player.position
	scene.call("_set_walk_target", Vector2(250, 620))
	_simulate(scene, 90)
	if not _check(player.position.x < initial.x - 100.0, "player did not move on foreground land"):
		return

	# Water must reject direct movement.
	var before_water := player.position
	scene.call("_set_walk_target", Vector2(1040, 620))
	_simulate(scene, 2)
	if not _check(player.position.distance_to(before_water) < 8.0, "player entered blocked water"):
		return
	var label := scene.get_node("UI/MessagePanel/Margin/Message") as Label
	if not _check("pont" in label.text.to_lower(), "water feedback should direct player to bridge"):
		return

	# Crossing must use bridge corridor.
	player.position = Vector2(560, 590)
	scene.call("_set_walk_target", Vector2(1080, 470))
	var visited_bridge := false
	for _i in range(300):
		scene.call("_process", 1.0 / 60.0)
		if player.position.x > 730.0 and player.position.x < 940.0 and player.position.y < 525.0:
			visited_bridge = true
	if not _check(visited_bridge, "player never entered bridge corridor"):
		return
	if not _check(player.position.x > 980.0 and player.position.y < 520.0, "player did not reach opposite bank through bridge"):
		return

	# Hotspot feedback.
	scene.call("_on_hotspot_activated", "mill")
	var panel := scene.get_node("UI/MessagePanel") as PanelContainer
	if not _check(panel.visible, "hotspot did not create visible feedback"):
		return
	if not _check("moulin" in label.text.to_lower(), "mill hotspot feedback missing"):
		return

	print("2D SMOKE PASSED: land movement, blocked water, bridge crossing, hotspots")
	quit(0)
