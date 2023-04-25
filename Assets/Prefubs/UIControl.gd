extends Control

onready var menu_button = get_node("menu_button")
onready var resume_button = get_node("settings/Panel/VBoxContainer/resume_button")
onready var settings_button = get_node("settings/Panel/VBoxContainer/settings_button")
onready var help_button = get_node("settings/Panel/VBoxContainer/help_button")
onready var save_and_exit = get_node("settings/Panel/VBoxContainer/save_and_exit")
onready var cancel_button = get_node("settings/subpanel/NinePatchRect/HBoxContainer/cancel_button")
onready var apply_button = get_node("settings/subpanel/NinePatchRect/HBoxContainer/apply_button")

func _ready():
	menu_button.connect("pressed", self, "_show_panel")
	resume_button.connect("pressed", self, "_resume")
	settings_button.connect("pressed", self, "_show_settings_panel")
	cancel_button.connect("pressed", self, "_close_settings_panel")
	apply_button.connect("pressed", self, "_apply_config")
	save_and_exit.connect("pressed", self, "_save_and_exit")

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
