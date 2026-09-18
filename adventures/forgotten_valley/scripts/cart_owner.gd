extends StaticBody3D

@export var cart_path: NodePath
@onready var cart: Node = get_node(cart_path)

func _ready() -> void:
	add_to_group("interactable")

func get_interaction_label(_player: PlayerController) -> String:
	return "Parler"

func interact(player: PlayerController) -> void:
	if cart.wheel_attached:
		player.show_message("Bien joué, tu as remis la roue ! Mais voyons si elle tient quand on pousse…")
	elif cart.wheel_failed_once:
		player.show_message("Aïe… elle ressort encore de l'axe. On n'a pas encore réparé le vrai problème.")
	elif cart.wheel_reattached_once:
		player.show_message("Tu as réussi à remettre la roue. Il faut encore vérifier si elle tient.")
	else:
		player.show_message("Oh ! Une pomme s'est échappée. Et ma charrette n'a pas l'air d'aller beaucoup mieux…")
