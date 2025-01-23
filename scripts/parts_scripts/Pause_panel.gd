extends Control

func _ready():
    var start_menu = get_node("MarginContainer/VBoxContainer").get_children()
    start_menu[0].pressed.connect(self._on_resume_pressed)
    start_menu[1].pressed.connect(self._on_main_menu_pressed)
    start_menu[2].pressed.connect(self._on_quit_pressed)


func _on_resume_pressed():
    # get_tree().change_scene_to_file("res://scenes/stage1.tscn")
    print("Resume")


func _on_main_menu_pressed():
    get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_quit_pressed():
    get_tree().quit()
