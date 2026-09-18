extends StaticBody3D

func _ready() -> void:
	add_to_group("interactable")

func get_interaction_label(_player: PlayerController) -> String:
	return "Examiner"

func interact(player: PlayerController) -> void:
	player.start_inspection("Borne ancienne", "☀   III\n\nUn soleil… et trois traits.")
