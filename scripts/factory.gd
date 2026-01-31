extends Node2D

var total_dec = load("res://scenes/quota_total_decimal.tscn")
var target = load("res://scenes/quota_target_amount.tscn")
var two_targets = load("res://scenes/quota_two_targets.tscn")
var under = load("res://scenes/quota_under.tscn")

var quotas = [total_dec,target,two_targets]
var operators = ["xor", "or", "and", "nand"]

var canStamp = false
var activeByte = null

var activeOperation = "xor"

var byte_scene: PackedScene = load("res://scenes/byte.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	add_quota()
	var byte: Node2D = byte_scene.instantiate()
	byte.global_position = global_position
	$Conveyor/ConveyorPath.add_child(byte)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("stamp") && canStamp && activeByte != null):
		mask(activeByte, activeOperation)
	if(Input.is_action_just_pressed("xor_switch")):
		activeOperation = "xor"
	if(Input.is_action_just_pressed("or_switch")):
		activeOperation = "or"
	if(Input.is_action_just_pressed("and_switch")):
		activeOperation = "and"
	if(Input.is_action_just_pressed("nand_switch")):
		activeOperation = "nand"

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
		print("-------")
		print("original: " + activeByte.number)
		var n = $numbers.nand(activeByte.number, $input.get_number())
		print("new: " + n)
		activeByte.set_number(n)
		print("------")
		
func add_quota():
	randomize()
	var curr_quota = quotas.pick_random()
	add_child(curr_quota.instantiate())
	var q = get_children()[get_child_count()-1]
	
	#activeOperation = operators.pick_random()
	activeOperation = "nand"
	$operator.text = activeOperation
	
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
		$loss.visible = true
		print("Fail so sad")

func byte_end(n:String):
	#For now, making the assumption that our quota will always be the last child
	var quota = get_children()[get_child_count()-1]
	quota.add_to_sum(n)

func _on_end_area_entered(area):
	var byte = area.get_parent()
	byte.connect("reached_end", byte_end.bind(byte.number))


func _on_stamp_zone_area_entered(area):
	canStamp = true
	activeByte = area.get_parent()

func _on_stamp_zone_area_exited(area):
	canStamp = false
	activeByte = null
