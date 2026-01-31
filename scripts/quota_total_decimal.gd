extends Node2D

var sum = 0
var target = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	target = randi_range(200, 500)
	$goal/goal_number.text = "Quota: " + str(target)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_to_sum(num:String):
	sum += num.bin_to_int()
	$counter.set_number(str(sum))

func end_of_round():
	if(sum < target):
		print("You fail so sad")
		return -1
	else:
		print("yay you win")
		return 1
