extends Control

signal notice_toggle_line(toggle_on: bool)
signal notice_resume_menu()


func _ready():
    var option_menu = get_node("MarginContainer/VBoxContainer").get_children()
    option_menu[0].toggled.connect(self._on_line_toggle)
    option_menu[1].pressed.connect(self._on_return_button)

    var menu = get_node("../PauseMenu")
    menu.notice_on_option_menu.connect(self._on_option_menu)

    visible = false

    option_menu[0].button_pressed = Global.visible_line

func _on_option_menu():
    print_debug("option")
    visible = true

func _on_return_button():
    visible = false
    notice_resume_menu.emit()


func _on_line_toggle(toggled_on: bool):
    print_debug(toggled_on)
    Global.visible_line = toggled_on
    notice_toggle_line.emit(toggled_on)
