extends Control

signal notice_resume_game()
signal notice_on_option_menu()

func _ready():
    var start_menu = get_node("MarginContainer/VBoxContainer").get_children()
    start_menu[0].pressed.connect(self._on_resume_pressed)
    start_menu[1].pressed.connect(self._on_option_pressed)
    start_menu[2].pressed.connect(self._on_main_menu_pressed)
    start_menu[3].pressed.connect(self._on_quit_pressed)

    var stage = get_node("../../")
    stage.notice_on_pause_menu.connect(self._on_pause_menu)
    stage.notice_off_pause_menu.connect(self._off_pause_menu)

    visible = false


func _on_pause_menu():
    visible = true


func _off_pause_menu():
    visible = false



func _on_resume_pressed():
    notice_resume_game.emit()
    visible = false

func _on_option_pressed():
    print("option")
    notice_on_option_menu.emit()


func _on_main_menu_pressed():
    get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_quit_pressed():
    get_tree().quit()
