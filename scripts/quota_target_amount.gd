extends Node2D

var sum = 0
var target = 0
var which_num = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	var which_num = randi_range(0,1)
	target = randi_range(80, 150)
	if(which_num == 0):
		$goal/goal_number.text = "Get " + str(target) + " 0s"
	else:
		$goal/goal_number.text = "Get: " + str(target) + " 1s"
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func add_to_sum(num:String):
	if(which_num == 0):
		sum += num.count("0")
	else:
		sum += num.count("1")
	$counter.set_number(str(sum))
	
func end_of_round():
	if(sum < target):
		print("You lose")
		return -1
	else:
		print("Yippie")
		return 1

#This is for manually setting which_num in quota_two_targets
func update_quota():
	if(which_num == 0):
		$goal/goal_number.text = "Get " + str(target) + " 0s"
	else:
		$goal/goal_number.text = "Get: " + str(target) + " 1s"
