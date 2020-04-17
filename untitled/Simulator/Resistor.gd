extends Node2D

export (float) var RESISTANCE = 1000.0

onready var terminalOne = $TerminalOne
onready var terminalTwo = $TerminalTwo

var _nodeVoltageOne
var _nodeVoltageTwo
var voltage
var current
var connectionOne = false
var connectionTwo = false
var isConnected = false

func _process(delta):
	updateStats()
	print("v1: ", _nodeVoltageOne)
	print("v2: ", _nodeVoltageTwo)
	print("voltage: ", voltage)
	print("current: ", current)

func updateStats():
	voltage = _nodeVoltageOne - _nodeVoltageTwo
	current = voltage / RESISTANCE


func _on_RestTerminalOne_nodeVoltageOne(nodeVoltageOne):
	_nodeVoltageOne = nodeVoltageOne


func _on_RestTerminalTwo_nodeVoltageTwo(nodeVoltageTwo):
	_nodeVoltageTwo = nodeVoltageTwo
