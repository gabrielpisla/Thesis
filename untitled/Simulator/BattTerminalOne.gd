extends Area2D

export(int) var nodeVoltageOne = 5.0


func _on_BattTerminalOne_area_entered(area):
	area.emit_signal("nodeVoltageOne", nodeVoltageOne)
