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
