extends CharacterBody2D

var speed: float = 0
var direction: Vector2 = Vector2.ZERO


func _ready():
    pass

func fire(target_position: Vector2):
    direction = (target_position - self.global_position).normalized()
    speed = 500

func _physics_process(_delta):
    velocity = direction * speed
    move_and_slide()