extends Node2D

var canType = true
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
		

	


func _on_number_text_changed():
	if(len($number.text) == 0):
		return
	var typed = $number.text[len($number.text)-1]
	if(typed != "0" && typed != "1"):
		$number.add_theme_color_override("font_placeholder_color", "red")
		$number.add_theme_color_override("font_outline_color", "red")
		$number.text = ""
	else:
		$number.add_theme_color_override("font_color", "white")
		$number.add_theme_color_override("font_outline_color", "white")
