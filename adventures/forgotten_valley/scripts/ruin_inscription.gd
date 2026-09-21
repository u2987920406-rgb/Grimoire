extends StaticBody3D

@export var title: String = "Inscription"
@export_multiline var detail: String = ""

func _ready() -> void:
	add_to_group("interactable")

func get_interaction_label(_player: PlayerController) -> String:
	return "Examiner"

func interact(player: PlayerController) -> void:
	player.start_inspection(title, detail)
