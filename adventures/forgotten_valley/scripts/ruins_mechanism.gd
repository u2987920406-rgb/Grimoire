extends StaticBody3D

@export var state_path: NodePath
@export var gate_path: NodePath
@onready var state: ValleyState = get_node(state_path)
@onready var gate: StaticBody3D = get_node(gate_path)
@onready var gate_collision: CollisionShape3D = gate.get_node("Collision")

func _ready() -> void:
	add_to_group("interactable")

func get_interaction_label(player: PlayerController) -> String:
	if state.ruins_open:
		return "Examiner le mécanisme"
	if player.held_object != null and player.held_object.has_method("is_sun_disc"):
		return "Insérer le disque solaire"
	return "Examiner le mécanisme"

func interact(player: PlayerController) -> void:
	if state.ruins_open:
		player.start_inspection("Mécanisme des ruines", "Le disque solaire est verrouillé dans son logement. Le passage vers l'intérieur est ouvert.")
		return

	if player.held_object != null and player.held_object.has_method("is_sun_disc"):
		var disc := player.take_held_object()
		disc.queue_free()
		state.open_ruins()
		gate.visible = false
		gate_collision.disabled = true
		gate.process_mode = Node.PROCESS_MODE_DISABLED
		player.show_message("Le disque s'emboîte exactement. Un grondement traverse la montagne et la porte de pierre s'abaisse.")
		return

	player.start_inspection("Mécanisme des ruines", "Au centre de la pierre, une cavité ronde porte le même symbole solaire que les bornes.")
