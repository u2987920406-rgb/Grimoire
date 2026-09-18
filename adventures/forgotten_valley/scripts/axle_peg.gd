extends CarryableBody

@export var retention_strength: float = 1.0

func _ready() -> void:
	interaction_name = "Cheville"
	importance = CarryableBody.Importance.CRITICAL
	recovery_radius = 12.0
	recovery_min_y = -0.5
	super._ready()

func is_axle_retainer() -> bool:
	return true
