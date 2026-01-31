extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func xor(x:String,y:String):
	var n = x.bin_to_int() ^ y.bin_to_int()
	return int_to_binary(n)
	
func bor(x:String,y:String):
	var n = x.bin_to_int() | y.bin_to_int()
	return int_to_binary(n)
	
func band(x:String,y:String):
	var n = x.bin_to_int() & y.bin_to_int()
	return int_to_binary(n)
	
func nand(x:String, y:String):
	var n = bnot(x.bin_to_int() & y.bin_to_int())
	return int_to_binary(n)
	
func bnot(x:int):
	var MAX_INT: int = 2**63 - 1
	MAX_INT <<= 8;
	var padded = MAX_INT | x
	padded = ~padded
	return padded
	
func int_to_binary(n:int):
	var bin = String.num_uint64(n,2)
	while(len(bin)<8):
		bin = "0" + bin
	return bin
