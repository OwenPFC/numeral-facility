extends Node2D

var total_dec = load("res://scenes/quota_total_decimal.tscn")
var target = load("res://scenes/quota_target_amount.tscn")
var two_targets = load("res://scenes/quota_two_targets.tscn")

var quotas = [total_dec,target,two_targets]

# Called when the node enters the scene tree for the first time.
func _ready():
	add_quota()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func add_quota():
	randomize()
	var curr_quota = quotas.pick_random()
	add_child(curr_quota.instantiate())
	$round_timer.start()

func _on_round_timer_timeout():
	#For now, making the assumption that our quota will always be the last child
	var quota = get_children()[get_child_count()-1]
	var win = quota.end_of_round()
	if(win == 1):
		quota.free()
		add_quota()
	else:
		print("Fail so sad")

func byte_end(n:String):
	#For now, making the assumption that our quota will always be the last child
	var quota = get_children()[get_child_count()-1]
	quota.add_to_sum(n)

func _on_end_area_entered(area):
	var byte = area.get_parent()
	byte.connect("reached_end", byte_end.bind(byte.number))
