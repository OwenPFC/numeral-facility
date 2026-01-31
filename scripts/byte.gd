extends PathFollow2D


signal reached_end


@export var speed: float = 0.01


var number: String = "00000000"


func _ready() -> void:
	var num = randi_range(0, 255)
	number = int_to_binary(num)
	$number.text = "[b]" + number

func _process(delta: float):
	var new_progress_ratio = progress_ratio + (delta * speed)

	# detect if it has reached the end
	if new_progress_ratio >= 1:
		reached_end.emit()
		queue_free()

	progress_ratio = new_progress_ratio
	
func set_number(n:String):
	number = n
	$number.text = "[b]" + number
	
func int_to_binary(n:int):
	var bin = String.num_uint64(n,2)
	while(len(bin)<8):
		bin = "0" + bin
	return bin
		
	
