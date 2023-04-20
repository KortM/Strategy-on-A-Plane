extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var single = $HBoxContainer/SingleModeButton
	single.connect("pressed", self, "_start_singl_mode")

func _start_singl_mode():
	get_tree().change_scene("res://Assets/Scenes/SingleMode.tscn")
