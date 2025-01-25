class_name Projectile
extends CharacterBody2D

var speed: float = 0
var direction: Vector2 = Vector2.ZERO
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_fire: bool = false
var is_falldown: bool = false

enum States {IDLE, FLIGHT, HIT, IDLEFIRE, FALLDOWN, KILL, GOAL}
var state: States = States.IDLE


func _ready():
    state = States.IDLE

    var wall = get_node("../Wall")
    wall.body_entered.connect(self._on_wall_body_entered)

    var enemies = get_tree().get_nodes_in_group("Enemy")
    for enemy in enemies:
        enemy.notice_hit_enemy.connect(self._on_hit_enemy)

    var goal = get_node("../Goal")
    goal.notice_hit_goal.connect(self._on_hit_goal)

    var killzone_enter = get_node("../Killzone")
    killzone_enter.notice_enter_killzone.connect(self._on_enter_killzone)


func _physics_process(_delta):
    match state:
        States.IDLE:
            idle()
        States.FLIGHT:
            flight(_delta)
        States.HIT:
            hit()
        States.IDLEFIRE:
            idle_fire()
        States.FALLDOWN:
            falldown()
        States.KILL:
            kill()
        States.GOAL:
            break_goal()

func change_state(next_state: States):
    state = next_state

func idle():
    print("idle_fire")
    if Input.is_action_just_pressed("B_button"):
        fire(get_global_mouse_position())
        change_state(States.FLIGHT)


func flight(_delta):
    print("flight")
    velocity = direction * speed
    move_and_slide()

# hitしたときに鉛直上向きに上昇
func hit():
    print("hit")
    speed = 0
    velocity = Vector2(0.0, -800)
    change_state(States.IDLEFIRE)

func idle_fire():
    velocity.y += gravity * 0.02
    move_and_slide()

    if Input.is_action_just_pressed("B_button"):
        fire(get_global_mouse_position())
        change_state(States.FLIGHT)

func falldown():
    velocity.y += gravity * 0.02
    move_and_slide()


func break_goal():
    velocity = Vector2(0.0, 0.0)
    direction = Vector2.ZERO
    speed = 0

func kill():
    move_and_slide()
    # TODO: bulletがanimationがあれば、
    print_debug("bullet enter killzone")

func fire(target_position: Vector2):
    direction = (target_position - self.global_position).normalized()



func _on_hit_enemy():
    change_state(States.HIT)

func _on_hit_goal():
    change_state(States.GOAL)

func _on_enter_killzone():
    change_state(States.KILL)

func _on_wall_body_entered(_body: Node2D):
    change_state(States.FALLDOWN)

func _process(_delta):
    draw_projectile_to_mouse()


# draw line
var point1: Vector2 = Vector2.ZERO
var point2 : Vector2 = Vector2.ZERO
var width : int = 3
var color : Color = Color.GREEN

func draw_projectile_to_mouse():
    point1 = global_position - position
    point2 = get_global_mouse_position() - position
    queue_redraw()


func _draw():
    if Global.visible_line == true:
        draw_circle(point1, 3, Color.WHITE)
        draw_circle(point2, 3, Color.GREEN)
        draw_line(point1, point2, color, width)
