extends StaticBody3D

@export var cart_path: NodePath
@export var state_path: NodePath
@onready var cart: Node = get_node(cart_path)
@onready var state: ValleyState = get_node(state_path)

func _ready() -> void:
	add_to_group("interactable")

func get_interaction_label(_player: PlayerController) -> String:
	return "Parler"

func interact(player: PlayerController) -> void:
	if not bool(cart.get("cart_repaired")):
		player.show_message("La route est encombrée plus bas. Le propriétaire de la charrette aurait bien besoin d'un coup de main.")
	elif state.water_setting == 0:
		player.show_message("Merci pour la charrette. Le moulin ne tourne plus depuis que l'eau part presque toute vers les cultures. La vieille vanne partage les deux canaux.")
	elif state.water_setting == 2:
		player.show_message("Le moulin tourne, oui… mais regarde les cultures : leur fossé est presque sec. On a seulement déplacé le problème.")
	elif state.water_setting == 1 and not state.sun_disc_revealed:
		player.show_message("Là, c'est mieux : moulin et cultures reçoivent tous les deux de l'eau. Quand le moulin tourne ainsi, les vieilles pierres de la vallée vibrent parfois.")
	elif not state.ruins_open:
		player.show_message("Ce disque porte le même soleil que les ruines sur la hauteur. J'irais voir là-haut.")
	else:
		player.show_message("Tu l'as ouvert… Je croyais ces ruines muettes depuis toujours.")
