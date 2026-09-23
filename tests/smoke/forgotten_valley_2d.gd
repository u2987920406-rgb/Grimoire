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
	print("2D SMOKE: start")
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

	print("2D SMOKE: scene loaded")
	# Land movement.
	var initial := player.position
	scene.call("_set_walk_target", Vector2(250, 620))
	_simulate(scene, 90)
	if not _check(player.position.x < initial.x - 100.0, "player did not move on foreground land"):
		return

	print("2D SMOKE: land movement ok")
	# Water must reject direct movement.
	var before_water := player.position
	scene.call("_set_walk_target", Vector2(1040, 620))
	_simulate(scene, 2)
	if not _check(player.position.distance_to(before_water) < 8.0, "player entered blocked water"):
		return
	var label := scene.get_node("UI/MessagePanel/Margin/Message") as Label
	if not _check("pont" in label.text.to_lower(), "water feedback should direct player to bridge"):
		return

	print("2D SMOKE: water rejection ok")
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

	print("2D SMOKE: bridge crossing ok")
	# Contextual action system.
	scene.call("_on_hotspot_activated", "mill")
	var action_panel := scene.get_node("UI/ActionPanel") as PanelContainer
	var examine_button := scene.get_node("UI/ActionPanel/Margin/VBox/Buttons/Examine") as Button
	var use_button := scene.get_node("UI/ActionPanel/Margin/VBox/Buttons/Use") as Button
	if not _check(action_panel.visible, "hotspot did not open contextual action panel"):
		return
	if not _check(not examine_button.disabled, "examine action should be available for mill"):
		return
	if not _check(not use_button.disabled, "use action should be available for mill"):
		return

	scene.call("_perform_action", "examine")
	var panel := scene.get_node("UI/MessagePanel") as PanelContainer
	if not _check(panel.visible, "examine action did not create visible feedback"):
		return
	if not _check("moulin" in label.text.to_lower(), "mill examine feedback missing"):
		return

	# Bridge use must trigger a real movement route.
	player.position = Vector2(560, 590)
	scene.call("_on_hotspot_activated", "bridge")
	scene.call("_perform_action", "use")
	_simulate(scene, 300)
	if not _check(player.position.x > 980.0 and player.position.y < 520.0, "bridge use action did not move player across"):
		return

	print("2D SMOKE PASSED: land movement, blocked water, bridge crossing, contextual actions")
	quit(0)
