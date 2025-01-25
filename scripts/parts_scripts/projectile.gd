extends CharacterBody2D

var speed: float = 0
var direction: Vector2 = Vector2.ZERO
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_fire: bool = false


func _ready():
    is_fire = true


func fire(target_position: Vector2):
    direction = (target_position - self.global_position).normalized()

func _physics_process(_delta):
    velocity = direction * speed
    move_and_slide()


# draw line
var point1: Vector2 = Vector2.ZERO
var point2 : Vector2 = Vector2.ZERO
var width : int = 3
var color : Color = Color.GREEN


func _process(_delta):
    point1 = global_position - position
    point2 = get_global_mouse_position() - position
    queue_redraw()

func _draw():
    draw_circle(point1, 3, Color.WHITE)
    draw_circle(point2, 3, Color.GREEN)
    draw_line(point1, point2, color, width)
