extends StaticBody3D

@export var action_label: String = "Examiner"
@export var inspection_title: String = "Lieu"
@export_multiline var inspection_detail: String = ""

func _ready() -> void:
	add_to_group("interactable")

func get_interaction_label(_player: PlayerController) -> String:
	return action_label

func interact(player: PlayerController) -> void:
	player.start_inspection(inspection_title, inspection_detail)
