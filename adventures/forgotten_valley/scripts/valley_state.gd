class_name ValleyState
extends Node

var water_setting: int = 0
var mill_restored: bool = false
var field_watered: bool = true
var sun_disc_revealed: bool = false
var ruins_open: bool = false
var ruins_flow_setting: int = 0
var ancient_network_restored: bool = false
var adventure_complete: bool = false

signal water_changed(setting: int)
signal mill_restored_changed(value: bool)
signal sun_disc_revealed_changed(value: bool)
signal ruins_opened
signal ruins_flow_changed(setting: int)
signal ancient_network_restored_changed(value: bool)
signal adventure_completed

func set_water_setting(value: int) -> void:
	water_setting = clampi(value, 0, 2)
	field_watered = water_setting <= 1
	var new_mill_restored := water_setting >= 1
	if new_mill_restored != mill_restored:
		mill_restored = new_mill_restored
		mill_restored_changed.emit(mill_restored)
	water_changed.emit(water_setting)

func reveal_sun_disc() -> void:
	if sun_disc_revealed:
		return
	sun_disc_revealed = true
	sun_disc_revealed_changed.emit(true)

func open_ruins() -> void:
	if ruins_open:
		return
	ruins_open = true
	ruins_opened.emit()

func set_ruins_flow_setting(value: int) -> void:
	ruins_flow_setting = clampi(value, 0, 2)
	var restored := ruins_flow_setting == 1
	if restored != ancient_network_restored:
		ancient_network_restored = restored
		ancient_network_restored_changed.emit(ancient_network_restored)
	ruins_flow_changed.emit(ruins_flow_setting)

func complete_adventure() -> void:
	if adventure_complete:
		return
	adventure_complete = true
	adventure_completed.emit()
