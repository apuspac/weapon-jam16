extends "res://scripts/parts_scripts/projectile.gd"

var is_falldown: bool = false

func _ready():
    super._ready()

    var wall = get_node("../Wall")
    wall.body_entered.connect(self._on_wall_body_entered)

    var enemys = get_node("../Enemy").get_children()
    for enemy in enemys:
        enemy.notice_hit_enemy.connect(self._on_hit_enemy)


func _physics_process(_delta):
    if is_fire == true and Input.is_action_just_pressed("B_button"):
        is_fire = false
        is_falldown = false
        fire(get_global_mouse_position())

    if is_falldown:
        velocity.y += gravity * 0.01
    else:
        velocity = direction * speed

    move_and_slide()

func _on_hit_enemy():
    print_debug("enemy hit")

    velocity = Vector2(0.0, -500)
    is_falldown = true
    is_fire = true



func _on_wall_body_entered(_body: Node2D):
    print_debug("wall hit")
    velocity = Vector2.ZERO
    speed = 0
    is_falldown = true

