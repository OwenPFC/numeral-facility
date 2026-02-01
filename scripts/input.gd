extends Node2D

var canType = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$number.add_theme_constant_override("outline_size",8)
	$background.animation = "stamping"


func get_number():
	return $number.text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(len($number.text) < 8):
		if(Input.is_action_just_pressed("type0")):
			$number.text = $number.text + "0"
		if(Input.is_action_just_pressed("type1")):
			$number.text = $number.text + "1"
	if(Input.is_action_just_pressed("clear")):
		$number.text = ""
	
	

