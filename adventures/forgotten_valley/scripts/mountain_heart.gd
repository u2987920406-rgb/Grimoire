extends StaticBody3D

@export var state_path: NodePath
@onready var state: ValleyState = get_node(state_path)

func _ready() -> void:
	add_to_group("interactable")

func get_interaction_label(_player: PlayerController) -> String:
	if not state.ruins_open:
		return "Approcher"
	if not state.ancient_network_restored:
		return "Examiner le cœur"
	return "Réactiver le cœur"

func interact(player: PlayerController) -> void:
	if not state.ruins_open:
		player.show_message("Le passage vers les ruines est encore fermé.")
		return

	if not state.ancient_network_restored:
		player.start_inspection(
			"Le cœur de la vallée",
			"Deux conduits de pierre convergent ici, mais un seul reçoit encore du flux. Le mécanisme central semble attendre que les deux branches fonctionnent ensemble."
		)
		return

	state.complete_adventure()
	player.start_inspection(
		"Le cœur de la vallée",
		"Les deux conduits vibrent à l'unisson. L'eau se remet à circuler dans les anciens passages sous la pierre.\n\nLe moulin, les canaux, les bornes et ces ruines faisaient partie d'un même réseau.\n\nLa vallée n'était pas cassée : ses liens avaient été oubliés.\n\nFIN — La Vallée oubliée."
	)
