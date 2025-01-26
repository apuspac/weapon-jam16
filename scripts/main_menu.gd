extends Control

func _ready():
    var start_menu = get_node("MarginContainer/VBoxContainer").get_children()
    start_menu[0].pressed.connect(self._on_start_pressed)
    start_menu[1].pressed.connect(self._on_option_pressed)
    start_menu[2].pressed.connect(self._on_quit_pressed)


func _on_start_pressed():
    get_tree().change_scene_to_file("res://scenes/stage1.tscn")
    Bgm.play()
    print("start button pressed")


func _on_option_pressed():
    # get_tree().change_scene_to_file("res://scenes/stage1.tscn")
    print("option button pressed")

func _on_quit_pressed():
    get_tree().quit()
