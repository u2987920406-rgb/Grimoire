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

	var initial := player.position
	scene.call("_set_walk_target", Vector2(900, 620))
	for _i in range(120):
		await process_frame
	_check(player.position.x > initial.x + 200.0, "player did not move across walkable plane")
	_check(player.position.y >= 430.0 and player.position.y <= 650.0, "player escaped walkable vertical band")

	scene.call("_on_hotspot_activated", "mill")
	await process_frame
	var panel := scene.get_node("UI/MessagePanel") as PanelContainer
	var label := scene.get_node("UI/MessagePanel/Margin/Message") as Label
	_check(panel.visible, "hotspot did not create visible feedback")
	_check("moulin" in label.text.to_lower(), "mill hotspot feedback missing")

	print("2D SMOKE PASSED: load, move, hotspots, feedback")
	quit(0)
