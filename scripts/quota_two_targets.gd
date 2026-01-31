extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$quota_0.which_num = 0
	$quota_0.update_quota()
	$quota_1.which_num = 1
	$quota_1.update_quota()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func end_of_round():
	var zero = $quota_0.end_of_round()
	var one = $quota_1.end_of_round()
	
	if(zero == 1 && one == 1):
		return 1
	else:
		return -1

func round_time():
	return 90

func add_to_sum(num:String):
	$quota_0.add_to_sum(num)
	$quota_1.add_to_sum(num)
