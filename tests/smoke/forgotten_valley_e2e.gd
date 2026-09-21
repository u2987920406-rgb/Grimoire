extends SceneTree

func _initialize() -> void:
	call_deferred("_run")

func _fail(message: String) -> void:
	push_error("E2E SMOKE FAILED: " + message)
	quit(1)

func _check(condition: bool, message: String) -> void:
	if not condition:
		_fail(message)

func _run() -> void:
	var packed := load("res://adventures/forgotten_valley/scenes/bootstrap.tscn") as PackedScene
	_check(packed != null, "bootstrap scene must load")

	var world := packed.instantiate()
	root.add_child(world)
	await process_frame
	await process_frame

	var state := world.get_node_or_null("AdventureState") as ValleyState
	var player := world.get_node_or_null("Player") as PlayerController
	var cart := world.get_node_or_null("Cart")
	var wheel := world.get_node_or_null("Wheel") as CarryableBody
	var peg := world.get_node_or_null("AxlePeg") as CarryableBody
	var stone := world.get_node_or_null("AncientStone")
	var disc := world.get_node_or_null("SunDisc") as CarryableBody
	var ruins := world.get_node_or_null("RuinsMechanism")
	var gate := world.get_node_or_null("RuinsGate") as StaticBody3D
	var flow_control := world.get_node_or_null("RuinFlowControl")
	var heart := world.get_node_or_null("MountainHeart")

	_check(state != null, "AdventureState missing")
	_check(player != null, "Player missing")
	_check(cart != null and wheel != null and peg != null, "cart repair objects missing")
	_check(stone != null and disc != null, "solar clue objects missing")
	_check(ruins != null and gate != null and flow_control != null and heart != null, "ruins objects missing")

	# Cart repair loop.
	player.pick_up(wheel)
	cart.interact(player)
	_check(bool(cart.get("wheel_attached")), "wheel should attach")

	player.pick_up(peg)
	cart.interact(player)
	_check(bool(cart.get("wheel_retained")), "peg should retain wheel")

	await cart._push_cart(player)
	_check(bool(cart.get("cart_repaired")), "cart should be repaired after retained push")

	# Water consequences.
	state.set_water_setting(0)
	_check(not state.mill_restored and state.field_watered, "crop-priority water state invalid")

	state.set_water_setting(2)
	_check(state.mill_restored and not state.field_watered, "mill-priority consequence invalid")

	state.set_water_setting(1)
	_check(state.mill_restored and state.field_watered, "balanced water state invalid")

	# Reuse of the previously observed stone.
	stone.interact(player)
	_check(state.sun_disc_revealed, "balanced system should allow stone III to reveal disc")
	_check(disc.visible, "sun disc should become visible")

	# Ruins.
	player.pick_up(disc)
	ruins.interact(player)
	await process_frame
	_check(state.ruins_open, "sun disc should open ruins")
	var gate_collision := gate.get_node("Collision") as CollisionShape3D
	_check(gate_collision.disabled, "ruins gate collision should be disabled")

	# Final ruins transfer puzzle: opening the door is not yet the ending.
	heart.interact(player)
	_check(not state.adventure_complete, "heart must not complete before ancient network is balanced")

	flow_control.interact(player)
	_check(state.ruins_flow_setting == 1, "first flow adjustment should reach balanced setting")
	_check(state.ancient_network_restored, "balanced ruin flow should restore ancient network")

	heart.interact(player)
	_check(state.adventure_complete, "mountain heart should complete after ancient network restoration")

	print("E2E SMOKE PASSED: cart -> water -> stone III -> disc -> ruins flow -> ending")
	quit(0)
