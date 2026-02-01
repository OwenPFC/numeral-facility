class_name ByteSpawner
extends Node2D


@export var byte_scene: PackedScene
var speed = .055
	
func _on_spawn_timer_timeout():
	# the conveyor must exist
	if Conveyor.instance == null:
		return
	var byte: Node2D = byte_scene.instantiate()
	byte.speed = speed
	byte.global_position = global_position
	Conveyor.instance.conveyor_path.add_child(byte)
	print("speed" + str(speed))
	print("wait time: " + str($SpawnTimer.wait_time))
	
func lower_time():
	$SpawnTimer.wait_time-=.1

