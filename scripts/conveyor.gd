class_name Conveyor 
extends Node2D


# the global conveyor class; a singleton

static var instance: Conveyor


@onready var conveyor_path: Path2D = $ConveyorPath


func _enter_tree() -> void:
	instance = self


func _exit_tree() -> void:
	instance = null

