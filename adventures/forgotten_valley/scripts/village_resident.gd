extends StaticBody3D

@export var cart_path: NodePath
@onready var cart: Node = get_node(cart_path)

func _ready() -> void:
	add_to_group("interactable")

func get_interaction_label(_player: PlayerController) -> String:
	return "Parler"

func interact(player: PlayerController) -> void:
	if bool(cart.get("cart_repaired")):
		player.show_message("Tu viens de la route basse ? Alors tu as dû voir la vieille borne. Le moulin, lui, fait un drôle de bruit depuis ce matin.")
	else:
		player.show_message("La route est encombrée plus bas. Le propriétaire de la charrette aurait bien besoin d'un coup de main.")
