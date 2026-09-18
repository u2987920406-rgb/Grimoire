class_name SimpleNpc
extends StaticBody3D

@export_multiline var dialogue_text: String = "Bonjour."

func _ready() -> void:
	add_to_group("interactable")

func get_interaction_label(_player: PlayerController) -> String:
	return "Parler"

func interact(player: PlayerController) -> void:
	player.show_message(dialogue_text)
