class_name MainMenu
extends Control


@export var main_game_scene: PackedScene = preload("res://scenes/main.tscn")


func _on_play_button_pressed():
	MonitorSceneLoader.load_scene_to_monitors(main_game_scene)

