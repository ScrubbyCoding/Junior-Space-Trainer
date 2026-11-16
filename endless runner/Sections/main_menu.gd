extends Control


#var endless:bool
@export var difficultyScreen:Control
@export var mainScreen:Control

var GameplayScene:PackedScene = preload("res://Scenes/endless_runner.tscn")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _difficultyScreen(endlessMode:bool):
	difficultyScreen.visible = true
	mainScreen.visible = false
	ObstacleGenerator.endless = endlessMode
	if endlessMode:
		print("endless")
	else:
		print ("not endless")
func _backButton():
	difficultyScreen.visible = false
	mainScreen.visible = true
	print("back")


func _startGame(targetDifficulty:int) -> void:
	ObstacleGenerator.difficulty = targetDifficulty
	var scene = GameplayScene.instantiate()
	get_tree().root.add_child(scene)
	#scene.get_parent().remove_child(scene)
	
	print("we get here at least")
	queue_free()
	#print();


func _on_button_pressed() -> void:
	pass # Replace with function body.
