extends StaticBody3D

@export var state_path: NodePath
@onready var state: ValleyState = get_node(state_path)
@onready var wheel: MeshInstance3D = $MillWheel

func _ready() -> void:
	add_to_group("interactable")
	state.water_changed.connect(_on_water_changed)

func _process(delta: float) -> void:
	if state.mill_restored:
		wheel.rotate_x(delta * 1.8)

func get_interaction_label(_player: PlayerController) -> String:
	return "Examiner le moulin"

func interact(player: PlayerController) -> void:
	if state.water_setting == 0:
		player.start_inspection("Le vieux moulin", "La roue est immobile. Un mince filet d'eau arrive au canal, mais pas assez pour l'entraîner.")
	elif state.water_setting == 1:
		player.start_inspection("Le vieux moulin", "La roue tourne régulièrement. Le canal reçoit assez d'eau sans assécher le fossé des cultures.")
	else:
		player.start_inspection("Le vieux moulin", "La roue tourne vite. Beaucoup d'eau arrive ici… peut-être trop au détriment d'autre chose.")

func _on_water_changed(_setting: int) -> void:
	pass
