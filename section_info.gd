class_name section_info

var scene : PackedScene

#number from 0-1
var weight : float
var gameScene:PackedScene = preload("res://Scenes/endless_runner.tscn")

func _init(targetScene:PackedScene, rarityWeight:float):
	scene = targetScene
	weight = rarityWeight
