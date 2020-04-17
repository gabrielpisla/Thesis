extends Area2D

export(int) var nodeVoltageTwo = 2.0




func _on_BattTerminalTwo_area_entered(area):
	area.emit_signal("nodeVoltageTwo", nodeVoltageTwo)
