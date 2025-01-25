# extends "res://scripts/parts_scripts/projectile.gd"
extends Projectile


func _ready():
    # projectile.gdの_read()
    super._ready()

func flight(_delta):
    velocity = direction * speed
    move_and_slide()

func fire(target_position: Vector2):
    super.fire(target_position)
    speed = 2000


