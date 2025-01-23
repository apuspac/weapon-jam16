extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if Input.is_action_just_pressed("A_button"):
        stage_cleared()


func stage_cleared():
    get_tree().change_scene_to_file("res://scenes/main_menu.tscn")