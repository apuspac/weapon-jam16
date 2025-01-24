extends Node2D

func _process(_delta):
    pass


# var bullet_path = preload("res://scenes/parts_scenes/bullet.tscn")

# func _process(_delta):
#     look_at(get_global_mouse_position())
#     if Input.is_action_just_pressed("A_button"):
#         print_debug("fire")
#         fire()

# func fire():
#     var bullet = bullet_path.instantiate()
#     bullet.direction = rotation
#     bullet.pos = global_position
#     bullet.rotate_angle = global_rotation
#     get_parent().add_child(bullet)
