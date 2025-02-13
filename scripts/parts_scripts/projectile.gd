class_name Projectile
extends CharacterBody2D

var speed: float = 0
var direction: Vector2 = Vector2.ZERO
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_fire: bool = false
var is_falldown: bool = false

enum States {IDLE, FLIGHT, HIT, IDLEFIRE, FALLDOWN, KILL, GOAL}
var state: States = States.IDLE

@onready var projectile_sprite = get_node("Sprite2D")
@onready var shoot_sfx = get_node("ShootSFX")
@onready var falldown_sfx = get_node("FalldownSFX")

@onready var root_stage = get_parent()
@onready var falldown_timer = get_node("Timer")


func _ready():
    state = States.IDLE

    # var wall = get_node("../Wall")
    # wall.body_entered.connect(self._on_wall_body_entered)

    var enemies = get_tree().get_nodes_in_group("Enemy")
    for enemy in enemies:
        enemy.notice_hit_enemy.connect(self._on_hit_enemy)

    var goal = get_node("../Goal")
    goal.notice_hit_goal.connect(self._on_hit_goal)

    var killzone_enter = get_node("../Killzone")
    killzone_enter.notice_enter_killzone.connect(self._on_enter_killzone)

    falldown_timer.timeout.connect(self._on_falldown_timer_timeout)


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
    print_debug(state, "->", next_state)
    state = next_state

func idle():
    if Input.is_action_just_pressed("left_click"):
        fire(get_global_mouse_position())
        change_state(States.FLIGHT)


func flight(_delta):
    velocity = direction * speed
    move_and_slide()

# hitしたときに鉛直上向きに上昇
func hit():
    speed = 0
    velocity = Vector2(0.0, -800)
    change_state(States.IDLEFIRE)

func idle_fire():
    velocity.y += gravity * 0.02
    move_and_slide()

    if Input.is_action_just_pressed("left_click"):
        fire(get_global_mouse_position())
        change_state(States.FLIGHT)
        Engine.time_scale = 1.0

    # if Input.is_action_pressed("right_click"):
    #     Engine.time_scale = 0.5
    # else:
    #     Engine.time_scale = 1.0

func falldown():
    set_collision_layer_value(1, false)
    set_collision_mask_value(2, false)
    falldown_sfx.play()
    falldown_timer.start(1.0)

    velocity = Vector2.ZERO

    change_state(States.KILL)



func break_goal():
    velocity = Vector2(0.0, 0.0)
    direction = Vector2.ZERO
    speed = 0

var falldown_rotate_angle: float = 0.0
func kill():
    velocity.y += gravity * 0.02
    move_and_slide()
    falldown_rotate_angle += 0.2
    sprite_rotation(falldown_rotate_angle)
    # TODO: bulletがanimationがあれば、
    # print_debug("bullet enter killzone")

func fire(target_position: Vector2):
    shoot_sfx.play()
    direction = (target_position - self.global_position).normalized()



func _on_hit_enemy(_enemy_id: int):
    change_state(States.HIT)

func _on_hit_goal():
    change_state(States.GOAL)

func _on_enter_killzone():
    change_state(States.KILL)

# func _on_wall_body_entered(_body: Node2D):
#     change_state(States.FALLDOWN)

func _on_wall_collision():
    print_debug("wall collision")
    change_state(States.FALLDOWN)


func _on_falldown_timer_timeout():
    print_debug("timerout")
    root_stage.stage_restart()

func _process(_delta):
    draw_projectile_to_mouse()

    # wallのcollision検知
    if state == States.FLIGHT or state == States.IDLEFIRE:
        if is_on_floor() or is_on_wall() or is_on_ceiling():
            _on_wall_collision()


func sprite_rotation(angle: float):
    projectile_sprite.rotation = angle




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
