extends StaticBody3D

@export var state_path: NodePath
@onready var state: ValleyState = get_node(state_path)
@onready var handle: Node3D = $Handle

func _ready() -> void:
	add_to_group("interactable")
	_update_visual()

func get_interaction_label(_player: PlayerController) -> String:
	return "Déplacer la vanne"

func interact(player: PlayerController) -> void:
	var next_setting := (state.water_setting + 1) % 3
	state.set_water_setting(next_setting)
	_update_visual()
	match state.water_setting:
		0:
			player.show_message("La vanne envoie presque toute l'eau vers les cultures. Le canal du moulin faiblit.")
		1:
			player.show_message("L'eau se partage entre le canal du moulin et les cultures.")
		2:
			player.show_message("La vanne envoie presque toute l'eau vers le moulin. Le fossé des cultures se vide.")

func _update_visual() -> void:
	handle.rotation_degrees.z = [-35.0, 0.0, 35.0][state.water_setting]
