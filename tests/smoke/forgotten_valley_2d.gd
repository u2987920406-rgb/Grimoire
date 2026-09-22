extends SceneTree

func _initialize() -> void:
	call_deferred("_run")

func _fail(message: String) -> void:
	push_error("2D SMOKE FAILED: " + message)
	quit(1)

func _check(condition: bool, message: String) -> void:
	if not condition:
		_fail(message)

func _run() -> void:
	var packed := load("res://adventures/forgotten_valley/scenes/village_2d.tscn") as PackedScene
	_check(packed != null, "village_2d scene must load")
	var scene := packed.instantiate()
	root.add_child(scene)
	await process_frame
	await process_frame

	var player := scene.get_node_or_null("World/Player") as Sprite2D
	_check(player != null, "2D player missing")
	_check(scene.get_node_or_null("World/MillHotspot") != null, "mill hotspot missing")
	_check(scene.get_node_or_null("World/BridgeHotspot") != null, "bridge hotspot missing")
	_check(scene.get_node_or_null("World/RuinsHotspot") != null, "ruins hotspot missing")
	_check(scene.get_node_or_null("World/HouseHotspot") != null, "house hotspot missing")

	# Basic walkable land movement.
	var initial := player.position
	scene.call("_set_walk_target", Vector2(250, 620))
	for _i in range(90):
		await process_frame
	_check(player.position.x < initial.x - 100.0, "player did not move on foreground land")

	# Clicking water must not start a route through the river.
	var before_water := player.position
	scene.call("_set_walk_target", Vector2(1040, 620))
	await process_frame
	_check(player.position.distance_to(before_water) < 8.0, "player entered blocked water")
	var label := scene.get_node("UI/MessagePanel/Margin/Message") as Label
	_check("pont" in label.text.to_lower(), "water feedback should direct player to bridge")

	# Crossing to the opposite bank must route over the bridge, not through water.
	player.position = Vector2(560, 590)
	scene.call("_set_walk_target", Vector2(1080, 470))
	var visited_bridge := false
	for _i in range(300):
		await process_frame
		if player.position.x > 730.0 and player.position.x < 940.0 and player.position.y < 525.0:
			visited_bridge = true
	_check(visited_bridge, "player never entered bridge corridor")
	_check(player.position.x > 980.0 and player.position.y < 520.0, "player did not reach opposite bank through bridge")

	# Hotspot feedback remains functional.
	scene.call("_on_hotspot_activated", "mill")
	await process_frame
	var panel := scene.get_node("UI/MessagePanel") as PanelContainer
	_check(panel.visible, "hotspot did not create visible feedback")
	_check("moulin" in label.text.to_lower(), "mill hotspot feedback missing")

	print("2D SMOKE PASSED: land movement, blocked water, bridge crossing, hotspots")
	quit(0)
