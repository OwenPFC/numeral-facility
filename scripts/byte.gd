extends PathFollow2D


signal reached_end


@export var speed: float = 0.1


func _process(delta: float):
	var new_progress_ratio = progress_ratio + (delta * speed)

	# detect if it has reached the end
	if new_progress_ratio >= 1:
		reached_end.emit()
		queue_free()

	progress_ratio = new_progress_ratio
