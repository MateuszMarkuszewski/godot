extends Node

onready var stickman = preload("res://Stickman.tscn")

func _ready():
	var s = stickman.instance()
	add_child(s)
