extends CarryableBody

func _ready() -> void:
	interaction_name = "Disque solaire"
	importance = CarryableBody.Importance.CRITICAL
	recovery_radius = 14.0
	recovery_min_y = -0.5
	super._ready()

func is_sun_disc() -> bool:
	return true
