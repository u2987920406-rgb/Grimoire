extends StaticBody3D

@export var state_path: NodePath
@onready var state: ValleyState = get_node(state_path)

func _ready() -> void:
	add_to_group("interactable")

func get_interaction_label(_player: PlayerController) -> String:
	return "Approcher"

func interact(player: PlayerController) -> void:
	if not state.ruins_open:
		player.show_message("Le passage vers les ruines est encore fermé.")
		return
	state.complete_adventure()
	player.start_inspection("Le cœur de la vallée", "Sous la pierre, l'eau circule dans d'anciens conduits. Le moulin, les canaux et les bornes faisaient autrefois partie d'un même réseau.\n\nLa vallée n'était pas cassée : ses liens avaient été oubliés.\n\nFIN — prototype E2E de La Vallée oubliée.")
