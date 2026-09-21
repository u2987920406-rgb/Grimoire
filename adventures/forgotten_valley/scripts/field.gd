extends StaticBody3D

@export var state_path: NodePath
@onready var state: ValleyState = get_node(state_path)

func _ready() -> void:
	add_to_group("interactable")

func get_interaction_label(_player: PlayerController) -> String:
	return "Observer les cultures"

func interact(player: PlayerController) -> void:
	if state.water_setting == 2:
		player.start_inspection("Les cultures", "Le petit fossé est presque sec. La terre commence déjà à perdre son humidité en surface.")
	elif state.water_setting == 1:
		player.start_inspection("Les cultures", "Un filet d'eau continue d'irriguer les rangées. Rien ne semble gaspillé.")
	else:
		player.start_inspection("Les cultures", "L'eau coule largement entre les rangées. Les plantes en reçoivent beaucoup.")
