extends StaticBody3D

@export var cart_path: NodePath
@onready var cart: Node = get_node(cart_path)

func _ready() -> void:
	add_to_group("interactable")

func get_interaction_label(_player: PlayerController) -> String:
	return "Parler"

func interact(player: PlayerController) -> void:
	if bool(cart.get("cart_repaired")):
		player.show_message("Ça tient ! Merci. Là, on peut vraiment repartir.")
	elif bool(cart.get("wheel_attached")) and bool(cart.get("wheel_retained")):
		player.show_message("Cette fois la roue est retenue. Il ne reste plus qu'à essayer de pousser.")
	elif bool(cart.get("wheel_attached")):
		player.show_message("Bien joué, tu as remis la roue ! Mais voyons si elle tient quand on pousse…")
	elif bool(cart.get("wheel_failed_once")):
		player.show_message("Aïe… elle ressort encore de l'axe. Le petit trou au bout doit sûrement servir à la retenir.")
	elif bool(cart.get("wheel_reattached_once")):
		player.show_message("Tu as réussi à remettre la roue. Il faut encore vérifier si elle tient.")
	else:
		player.show_message("Oh ! Une pomme s'est échappée. Et ma charrette n'a pas l'air d'aller beaucoup mieux…")
