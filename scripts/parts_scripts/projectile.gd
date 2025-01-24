extends CharacterBody2D

var speed: float = 0
var direction: Vector2 = Vector2.ZERO
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_fire: bool = false


func _ready():
    is_fire = true


func fire(target_position: Vector2):
    direction = (target_position - self.global_position).normalized()
    speed = 500

func _physics_process(_delta):
    velocity = direction * speed
    move_and_slide()

# func _on_body_entered(body) -> void:
#     pass
    # if body.is_in_group("enemy"):
    #     body.queue_free()
    #     queue_free()