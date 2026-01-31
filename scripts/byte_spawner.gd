class_name ByteSpawner
extends Node2D


@export var byte_scene: PackedScene
	
	
func _on_spawn_timer_timeout():
	# the conveyor must exist
	if Conveyor.instance == null:
		return

	var byte: Node2D = byte_scene.instantiate()
	byte.global_position = global_position
	Conveyor.instance.conveyor_path.add_child(byte)

