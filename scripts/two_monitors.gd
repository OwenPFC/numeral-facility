extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#The 2nd child of a counter is its textbox
	$one_count.get_child(1).text = "1s: "
	$zero_count.get_child(1).text = "0s: "


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_zero(num:int):
	$zero_count.get_child(1).text = "0s: " + str(num)

func set_one(num:int):
	$one_count.get_child(1).text = "1s: " + str(num)
