extends StaticBody3D

@export var state_path: NodePath
@export var stone_index: int = 3
@export var sun_disc_path: NodePath
@onready var state: ValleyState = get_node(state_path)
@onready var sun_disc: RigidBody3D = get_node(sun_disc_path)

func _ready() -> void:
	add_to_group("interactable")
	if stone_index == 3 and not state.sun_disc_revealed:
		sun_disc.visible = false
		sun_disc.freeze = true
		sun_disc.process_mode = Node.PROCESS_MODE_DISABLED

func get_interaction_label(_player: PlayerController) -> String:
	return "Examiner"

func interact(player: PlayerController) -> void:
	if stone_index != 3:
		player.start_inspection("Borne ancienne", "☀   %s\n\nUne borne marquée du soleil." % _roman(stone_index))
		return

	if not state.mill_restored:
		player.start_inspection("Borne ancienne", "☀   III\n\nUn soleil… et trois traits. Une fine rainure entoure le symbole.")
		return

	if not state.sun_disc_revealed:
		state.reveal_sun_disc()
		sun_disc.process_mode = Node.PROCESS_MODE_INHERIT
		sun_disc.freeze = false
		sun_disc.visible = true
		sun_disc.global_position = global_position + Vector3(0.0, 0.25, 0.9)
		player.show_message("La vibration du moulin fait bouger la pierre. Un petit disque gravé du même soleil tombe d'une cavité.")
	else:
		player.start_inspection("Borne ancienne", "☀   III\n\nLa cavité derrière le symbole est maintenant vide.")

func _roman(value: int) -> String:
	return ["I", "II", "III", "IV"][clampi(value - 1, 0, 3)]
