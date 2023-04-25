extends Control

onready var menu_button = get_node("menu_button")
onready var resume_button = get_node("settings/Panel/VBoxContainer/resume_button")
onready var settings_button = get_node("settings/Panel/VBoxContainer/settings_button")
onready var help_button = get_node("settings/Panel/VBoxContainer/help_button")
onready var save_and_exit = get_node("settings/Panel/VBoxContainer/save_and_exit")
onready var cancel_button = get_node("settings/subpanel/NinePatchRect/HBoxContainer/cancel_button")
onready var apply_button = get_node("settings/subpanel/NinePatchRect/HBoxContainer/apply_button")
onready var build_panel = get_node("NinePatchRect/HBoxContainer/Panel/build_panel")
onready var one_build_panel = get_node("NinePatchRect/HBoxContainer/Panel/build_panel/TextureButton")
onready var build_button_back = get_node("NinePatchRect/HBoxContainer/Panel/build_panel/button_back")
var build_buttons = []

func _ready():
	menu_button.connect("pressed", self, "_show_panel")
	resume_button.connect("pressed", self, "_resume")
	settings_button.connect("pressed", self, "_show_settings_panel")
	cancel_button.connect("pressed", self, "_close_settings_panel")
	apply_button.connect("pressed", self, "_apply_config")
	save_and_exit.connect("pressed", self, "_save_and_exit")
	one_build_panel.connect("pressed", self, "one_build_button")
	build_button_back.connect("pressed", self, "build_button_back")
	for i in range(build_panel.get_child_count()):
		build_buttons.append(build_panel.get_child(i))

func _show_panel():
	$settings/Panel.visible = true

func _resume():
	$settings/Panel.visible = false

func _show_settings_panel():
	$settings/subpanel.visible = true

func _close_settings_panel():
	$settings/subpanel.visible = false

func _apply_config():
	$settings/subpanel.visible = false

func _save_and_exit():
	print("Сохраняю и выхожу")
	get_tree().change_scene("res://Assets/Scenes/Start.tscn")

func one_build_button():
	#удаляем все кнопки из панели строительства
	#добавляем кнопку назад и кнопку здания
	for i in range(build_panel.get_child_count()):
		build_panel.remove_child(build_panel.get_child(0))
	print("Drop all element")
	build_panel.add_child(build_button_back)
	build_panel.add_child(one_build_panel)
	
func build_button_back():
	#Возращаем все кнопки кроме кнопок back и cancel
	print("Back")
	build_panel.remove_child(build_panel.get_child(0))
	for i in build_buttons:
		if i.name != "button_back" and i.name != "button_cancel":
			build_panel.add_child(i)
