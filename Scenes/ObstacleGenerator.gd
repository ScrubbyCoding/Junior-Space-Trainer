extends Node2D
class_name ObstacleGenerator

var progress: int = 0
#placeholder
var maxProgress: int = 100

var EmptySection = preload("res://endless runner/Sections/EmptySection.tscn")
var ChasmsSection = preload("res://endless runner/Sections/Chasms.tscn")
var DifficultSection = preload("res://endless runner/Sections/Difficult.tscn")
var RockySection = preload("res://endless runner/Sections/Mildly_rocky.tscn")
var ExtraDifficultSection = preload("res://endless runner/Sections/ExtraDifficult.tscn")


var currentLevel: Array[section_info]


var beginnerLevel : Array[section_info] = [
	section_info.new(EmptySection, 0.2), 
	section_info.new(ChasmsSection, 0.4),
	section_info.new(DifficultSection, 0.1),
	section_info.new(RockySection, 1),
	]

var intermediateLevel : Array[section_info] = [
	section_info.new(EmptySection, 0), 
	section_info.new(ChasmsSection, 0.8),
	section_info.new(DifficultSection, 0.5),
	section_info.new(RockySection, 0.8),
	section_info.new(ExtraDifficultSection, 0.1)
	]
	
var hardLevel : Array[section_info] = [ 
	section_info.new(ChasmsSection, 0.5),
	section_info.new(DifficultSection, 0.5),
	section_info.new(RockySection, 0.3),
	section_info.new(ExtraDifficultSection, 0.5)
	]


var currentSections : Array[Node2D]
var scrollSpeed = 600

#var width = 1008
var offset = 0
var finished:bool

@export var victoryImage:Control

var timeToSurvive:float = 10;
static var endless:bool
static var difficulty:int

var started:bool = false
var random = RandomNumberGenerator.new()

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	victoryImage.visible = true
	finished = true

func finishGame() -> void: 
	if not endless:
		wait(timeToSurvive)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if difficulty == 1:
		currentLevel = beginnerLevel
	if difficulty == 2:
		currentLevel = intermediateLevel
	if difficulty == 3:
		currentLevel = hardLevel
	currentLevel = hardLevel
	victoryImage.visible = false
	victoryImage.modulate = Color(1,1,1, 0)
	var beg = EmptySection.instantiate()
	currentSections.append(beg)
	add_child(beg)
	
	var beg2:Node2D = EmptySection.instantiate()
	
	var potWidth:int = 0
	for node in beg2.get_children(): 
		if node is TileMapLayer:
			var nodeWidth:int = node.get_used_rect().size.x * 48
			if potWidth < nodeWidth:
				potWidth = nodeWidth
				
	#print(potWidth)
	var width = returnBiggestTileWidth(beg2)
	beg2.position.x = width

	currentSections.append(beg2)
	add_child(beg2)
	startGame()

	pass # Replace with function body.
	
func returnBiggestTileWidth(inputNode:Node2D) -> int:
	var potWidth:int = -1
	for node in inputNode.get_children(): 
		if node is TileMapLayer:
			var nodeWidth:int = node.get_used_rect().size.x * 48
			if potWidth < nodeWidth:
				potWidth = nodeWidth
	return potWidth
	
func startGame() -> void:
	await get_tree().create_timer(0).timeout
	finishGame()
	started = true

func _getNextNode() -> PackedScene:
	var weights: PackedFloat32Array
	for section_info in currentLevel:
		weights.append(section_info.weight)
	
	var index = random.rand_weighted(weights)
	
	return currentLevel[index].scene

func _spawnNextNode() -> void:
	var node = _getNextNode().instantiate()
	var width = returnBiggestTileWidth(node)
	currentSections.append(node)
	#node.position.x = width * 2 + offset
	node.position.x = currentSections.get(currentSections.size() - 2).position.x + width
	add_child(node)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if started:
		if finished and victoryImage.modulate.a >= 0:
			victoryImage.modulate = Color(1,1,1, victoryImage.modulate.a + delta)
		
		for c in currentSections: 
			c.position.x -= scrollSpeed * delta
			#if c.position.x < -1008 + offset:
			var width = returnBiggestTileWidth(c)
			if c.position.x < -width + offset:
				c.queue_free()
				currentSections.erase(c)
				_spawnNextNode()
			
	#for node : currentSections 
	pass
