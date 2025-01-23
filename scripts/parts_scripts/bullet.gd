extends "res://scripts/parts_scripts/projectile.gd"


func _physics_process(_delta):
    if Input.is_action_just_pressed("B_button"):
        fire(get_global_mouse_position())

    velocity = direction * speed
    move_and_slide()
