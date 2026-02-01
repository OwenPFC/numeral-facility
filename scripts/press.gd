class_name PressVisuals
extends Node2D


const ZERO_FRAME: int = 0
const ONE_FRAME: int = 1
const OPERATION_MAP := {
	"xor": 0,
	"or": 1,
	"and": 2
}


@onready var operation_sprite: Sprite2D = $PressHead/OperationSprite


func _ready():
	await get_tree().process_frame
	Factory.instance.operation_changed.connect(_factory_operation_changed)
	_factory_operation_changed(Factory.instance.activeOperation)


func _factory_operation_changed(new_op: String) -> void:
	operation_sprite.frame = OPERATION_MAP[new_op]
	
