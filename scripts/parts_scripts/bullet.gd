extends CharacterBody2D
var pos:Vector2
var rotate_angle: float
var direction: float
var speed = 0

func _ready():
    pass
    # global_position = pos
    # global_rotation = rotate_angle

func _physics_process(_delta):
    velocity = Vector2(speed, 0).rotated(direction)
    move_and_slide()

    if Input.is_action_just_pressed("B_button"):
        fire()

func fire():
    speed = 500
