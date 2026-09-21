extends StaticBody3D

@export var state_path: NodePath
@onready var state: ValleyState = get_node(state_path)
@onready var handle: Node3D = $Handle
@onready var left_flow: MeshInstance3D = $LeftFlow
@onready var right_flow: MeshInstance3D = $RightFlow

func _ready() -> void:
	add_to_group("interactable")
	_update_visuals()

func get_interaction_label(_player: PlayerController) -> String:
	return "Régler le répartiteur"

func interact(player: PlayerController) -> void:
	var next_setting := (state.ruins_flow_setting + 1) % 3
	state.set_ruins_flow_setting(next_setting)
	_update_visuals()
	match state.ruins_flow_setting:
		0:
			player.show_message("L'eau ancienne gronde dans le conduit gauche. Le conduit droit reste silencieux.")
		1:
			player.show_message("Le débit se partage. Les deux conduits vibrent ensemble et une lueur gagne le cœur de la salle.")
		2:
			player.show_message("Le flux bascule vers le conduit droit. Le conduit gauche s'éteint.")

func _update_visuals() -> void:
	handle.rotation_degrees.z = [-38.0, 0.0, 38.0][state.ruins_flow_setting]
	left_flow.visible = state.ruins_flow_setting <= 1
	right_flow.visible = state.ruins_flow_setting >= 1
