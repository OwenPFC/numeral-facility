extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
func xor(x:String,y:String):
	return x.bin_to_int() ^ y.bin_to_int()
	
func bor(x:String,y:String):
	return x.bin_to_int() | y.bin_to_int()
	
func band(x:String,y:String):
	return x.bin_to_int() & y.bin_to_int()	
