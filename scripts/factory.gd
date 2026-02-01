extends Node2D

var total_dec = load("res://scenes/quota_total_decimal.tscn")
var target = load("res://scenes/quota_target_amount.tscn")
var two_targets = load("res://scenes/quota_two_targets.tscn")
var under = load("res://scenes/quota_under.tscn")

#var quotas = [total_dec,target,two_targets, under]
var quotas = [under]
var operators = ["xor", "or", "and", "nand", "xor", "xor", "xor", "nand", "nand"]

var canStamp = false
var activeByte = null
var activeBytes:Dictionary = {}

var activeOperation = "xor"

var byte_scene: PackedScene = load("res://scenes/byte.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	add_quota()
	var byte: Node2D = byte_scene.instantiate()
	byte.global_position = global_position
	$Conveyor/ConveyorPath.add_child(byte)
	$input.get_child(0).play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("stamp") && activeBytes.size() > 0):
		print(activeBytes.size())
		activeBytes.erase(activeByte)
		print(activeBytes.size())
		$input.get_child(0).play()
		mask(activeByte, activeOperation)
		activeOperation = operators.pick_random()
		$input/operator.text = activeOperation
		

	$clock.text = "Time Remaining: " + str(snapped($round_timer.time_left, 0.01))
	
func mask(byte, operation:String):
	if(operation == "xor"): 
		var n = $numbers.xor(activeByte.number, $input.get_number())
		activeByte.set_number(n)
	elif(operation == "or"):
		var n = $numbers.bor(activeByte.number, $input.get_number())
		activeByte.set_number(n)
	elif(operation == "and"):
		var n = $numbers.band(activeByte.number, $input.get_number())
		activeByte.set_number(n)
	elif(operation == "nand"):
		print("original: " + activeByte.number)
		var n = $numbers.nand(activeByte.number, $input.get_number())
		activeByte.set_number(n)
	$ByteSpawner.lower_time()
	if($ByteSpawner.speed < 1):
			$ByteSpawner.speed += .02
		
func add_quota():
	randomize()
	var curr_quota = quotas.pick_random()
	add_child(curr_quota.instantiate())
	var q = get_children()[get_child_count()-1]
	
	activeOperation = operators.pick_random()
	$input/operator.text = activeOperation
	
	$round_timer.wait_time = q.round_time()
	$round_timer.start()

func _on_round_timer_timeout():
	#For now, making the assumption that our quota will always be the last child
	var quota = get_children()[get_child_count()-1]
	var win = quota.end_of_round()
	if(win == 1):
		quota.free()
		add_quota()
	else:
		$lose_screen.visible = true
		print("Fail so sad")

func byte_end(n:String):
	#For now, making the assumption that our quota will always be the last child
	var quota = get_children()[get_child_count()-1]
	print("adding to sum")
	quota.add_to_sum(n)

func _on_end_area_entered(area):
	var byte = area.get_parent()
	print(byte.number)
	byte.connect("reached_end", byte_end.bind(byte.number))


func _on_stamp_zone_area_entered(area):
	activeByte = area.get_parent()
	activeBytes[activeByte] = true
	

func _on_stamp_zone_area_exited(area):
	var byte = area.get_parent()
	activeBytes.erase(byte)
	
	
func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
