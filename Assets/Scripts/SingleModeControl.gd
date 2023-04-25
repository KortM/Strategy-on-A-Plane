extends Control

onready var dificult = ['Medium', 'Hight', 'Low']
onready var map_size = ['Medium', 'Big', 'Small']
var dif_count = 0
var map_count = 0


func _ready():
	var back_btn = $HBoxContainer/VBoxContainer/Button
	var start_btn = $HBoxContainer/VBoxContainer2/Button
	var d_switch_back = $HBoxContainer/VBoxContainer2/HBoxContainer/dif_switch_back
	var d_switch_next = $HBoxContainer/VBoxContainer2/HBoxContainer/dif_switch_next
	var map_back = $HBoxContainer/VBoxContainer2/HBoxContainer2/map_back
	var map_hext = $HBoxContainer/VBoxContainer2/HBoxContainer2/map_next
	
	back_btn.connect("pressed", self, "_back")
	start_btn.connect("pressed", self, "_start")
	d_switch_back.connect("pressed", self, "_dif_switch_back")
	d_switch_next.connect("pressed", self, "_dif_switch_next")
	map_back.connect("pressed", self, "_map_size_back")
	map_hext.connect("pressed", self, "_map_size_next")

func _back():
	get_tree().change_scene("res://Assets/Scenes/Start.tscn")

func _start():
	var settle_name = $HBoxContainer/VBoxContainer2/settle_name
	var info_label = $info_label
	if settle_name.text:
		get_tree().change_scene("res://Assets/Scenes/Main.tscn")
		info_label.visible = false
	else:
		info_label.text = "Set settlename please"
		info_label.visible = true

func _dif_switch_back():
	var dif = $HBoxContainer/VBoxContainer2/HBoxContainer/dificult
	
	if dif_count < 0:
		dif_count = len(dificult) - 1
	if dif_count > 2:
		dif_count = 0
	dif.text = dificult[dif_count]
	dif_count -=1

func _dif_switch_next():
	var dif = $HBoxContainer/VBoxContainer2/HBoxContainer/dificult
	if dif_count > 2:
		dif_count = 0
	if dif_count < 0:
		dif_count = len(dificult) - 1
	dif.text = dificult[dif_count]
	dif_count +=1

func _map_size_back():
	var map = $HBoxContainer/VBoxContainer2/HBoxContainer2/map_size
	if map_count < 0:
		map_count = len(map_size) - 1
	if map_count > 2:
		map_count = 0
	map.text = map_size[map_count]
	map_count -=1

func _map_size_next():
	var map = $HBoxContainer/VBoxContainer2/HBoxContainer2/map_size
	if map_count > 2:
		map_count = 0
	if map_count < 0:
		map_count = len(map_size) - 1
	map.text = map_size[map_count]
	map_count +=1
