extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$number.add_theme_constant_override("outline_size",8)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(len($number.text) > 8):
		$number.add_theme_color_override("font_placeholder_color", "red")
		$number.add_theme_color_override("font_outline_color", "red")
		$number.text = ""
	else:
		$number.add_theme_color_override("font_color", "white")
		$number.add_theme_color_override("font_outline_color", "white")

