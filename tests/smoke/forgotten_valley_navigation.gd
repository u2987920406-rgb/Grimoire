extends SceneTree

func _initialize() -> void:
	call_deferred("_run")

func _fail(message: String) -> void:
	push_error("NAVIGATION SMOKE FAILED: " + message)
	quit(1)

func _check(condition: bool, message: String) -> void:
	if not condition:
		_fail(message)

func _ray_hit(space: PhysicsDirectSpaceState3D, from: Vector3, to: Vector3) -> Dictionary:
	var query := PhysicsRayQueryParameters3D.create(from, to)
	query.collide_with_areas = false
	query.collide_with_bodies = true
	return space.intersect_ray(query)

func _run() -> void:
	var packed := load("res://adventures/forgotten_valley/scenes/bootstrap.tscn") as PackedScene
	_check(packed != null, "bootstrap scene must load")

	var world := packed.instantiate()
	root.add_child(world)
	await physics_frame
	await physics_frame

	var space: PhysicsDirectSpaceState3D = world.get_world_3d().direct_space_state

	# Every major playable checkpoint must have physical support below it.
	var checkpoints := {
		"start": Vector3(0, 5, 5.5),
		"cart": Vector3(2.2, 5, -0.3),
		"stone_iii": Vector3(0, 5, -3.0),
		"bridge": Vector3(2.2, 5, -5.2),
		"village": Vector3(1.0, 5, -8.3),
		"mill": Vector3(-2.4, 5, -9.2),
		"field": Vector3(-7.0, 5, -10.5),
		"mountain_path": Vector3(0.5, 5, -16.0),
		"ruins_gate": Vector3(0.5, 5, -20.0),
		"mountain_heart": Vector3(0.5, 5, -24.0),
	}
	for label in checkpoints:
		var p: Vector3 = checkpoints[label]
		var hit := _ray_hit(space, p, Vector3(p.x, -5.0, p.z))
		_check(not hit.is_empty(), "no physical support under " + label)

	# Ground visual/collision dimensions must stay aligned.
	var ground_mesh := world.get_node("Ground/Mesh") as MeshInstance3D
	var ground_collision := world.get_node("Ground/Collision") as CollisionShape3D
	var mesh_size: Vector3 = (ground_mesh.mesh as BoxMesh).size
	var shape_size: Vector3 = (ground_collision.shape as BoxShape3D).size
	_check(mesh_size.is_equal_approx(shape_size), "ground mesh and collision sizes differ")

	# Bridge must be an actual collider, not decoration.
	var bridge_collision := world.get_node("Bridge/Collision") as CollisionShape3D
	_check(bridge_collision != null and not bridge_collision.disabled, "bridge collision missing")

	# Perimeter must be closed in all four cardinal directions.
	var boundary_probes := [
		[Vector3(0, 1.2, 28.0), Vector3(0, 1.2, 31.0), "south"],
		[Vector3(0, 1.2, -28.0), Vector3(0, 1.2, -31.0), "north"],
		[Vector3(28.0, 1.2, 0), Vector3(31.0, 1.2, 0), "east"],
		[Vector3(-28.0, 1.2, 0), Vector3(-31.0, 1.2, 0), "west"],
	]
	for probe in boundary_probes:
		var hit := _ray_hit(space, probe[0], probe[1])
		_check(not hit.is_empty(), "world boundary missing on " + str(probe[2]))

	print("NAVIGATION SMOKE PASSED: ground, checkpoints, bridge and world limits")
	quit(0)
