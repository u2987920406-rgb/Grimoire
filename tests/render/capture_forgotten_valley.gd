extends SceneTree

func _initialize() -> void:
	call_deferred("_capture")

func _capture() -> void:
	var packed := load("res://adventures/forgotten_valley/scenes/bootstrap.tscn") as PackedScene
	if packed == null:
		push_error("Unable to load Forgotten Valley scene")
		quit(1)
		return

	var world := packed.instantiate()
	root.add_child(world)

	var viewport := root
	viewport.size = Vector2i(1280, 720)

	# Place player and camera at a representative village overlook.
	var player := world.get_node("Player") as PlayerController
	player.global_position = Vector3(1.0, 1.2, -1.0)
	player.controls_enabled = false

	var camera_rig := world.get_node("CameraRig") as Node3D
	var camera_pitch := world.get_node("CameraRig/CameraPitch") as Node3D
	camera_rig.global_position = player.global_position + Vector3(0.0, 1.0, 0.0)
	camera_rig.rotation_degrees = Vector3(0, 8, 0)
	camera_pitch.rotation_degrees = Vector3(-30, 0, 0)

	for _i in range(12):
		await process_frame

	var image := viewport.get_texture().get_image()
	if image.is_empty():
		push_error("Viewport capture returned empty image")
		quit(1)
		return

	var out_dir := "res://build/render"
	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(out_dir))
	var out_path := out_dir + "/forgotten_valley_real.png"
	var err := image.save_png(out_path)
	if err != OK:
		push_error("Failed to save screenshot: %s" % err)
		quit(1)
		return

	print("REAL_RENDER_SAVED:", out_path)
	quit(0)
