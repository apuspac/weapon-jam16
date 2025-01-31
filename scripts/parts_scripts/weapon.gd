extends Projectile


enum ProjectileType {BULLET, MISSILE, BOMB}
var projectile_type: ProjectileType = ProjectileType.BULLET

@onready var bullet_sprite = get_node("BulletSprite")
@onready var missile_sprite = get_node("MissileSprite")
@onready var bomb_sprite = get_node("BombSprite")


func _ready():
    super._ready()
    projectile_sprite.visible = false
    change_visible(0)




func flight(_delta):
    match projectile_type:
        ProjectileType.BULLET:
            flight_bullet()
        ProjectileType.MISSILE:
            flight_missile(_delta)
        ProjectileType.BOMB:
            flight_bomb(_delta)


func flight_bullet():
    velocity = direction * speed
    move_and_slide()


var stamina: float = 100.0
func flight_missile(_delta):
    if stamina > 0:
        var mouse_position = get_global_mouse_position()
        var _direction = (mouse_position - position).normalized()
        position += _direction * speed * _delta

        sprite_rotation(_direction.angle())
    else:
        sprite_rotation(90.0)
        change_state(States.FALLDOWN)

    # print(stamina)
    stamina -= 1.0


var bomb_gravity : Vector2 = Vector2(0, 750)
var rotate_angle : float = 0.0

func flight_bomb(_delta):
    velocity += bomb_gravity * _delta
    move_and_slide()
    sprite_rotation(rotate_angle)
    rotate_angle += 0.1


func fire(target_position: Vector2):
    match projectile_type:
        ProjectileType.BULLET:
            fire_bullet(target_position)
        ProjectileType.MISSILE:
            fire_missile(target_position)
        ProjectileType.BOMB:
            fire_bomb(target_position)


func fire_bullet(target_position: Vector2):
    super.fire(target_position)
    speed = 2000

    # if 水平に限定するのであれば。
    # var angle = direction.angle()
    # if angle < -PI/4:
    #     angle = -PI/4
    # elif angle > PI/4:
    #     angle = PI/4

    # direction = Vector2(cos(angle), sin(angle)).normalized()


func fire_missile(target_position: Vector2):
    super.fire(target_position)
    speed = 750
    stamina = 100.0

func fire_bomb(target_position: Vector2):
    super.fire(target_position)
    var mouse_distance = (target_position - global_position).length()
    speed = mouse_distance * 3.5
    velocity = direction * speed

    rotate_angle = direction.angle()
    print_debug(direction.angle())


func _on_hit_enemy(_enemy_id: int):
    print_debug(_enemy_id)


    change_state(States.HIT)
    change_visible(_enemy_id)

    match _enemy_id:
        0:
            projectile_type = ProjectileType.BULLET
        1:
            projectile_type = ProjectileType.MISSILE
        2:
            projectile_type = ProjectileType.BOMB

func change_visible(_enemy_id: int):
    match _enemy_id:
        0:
            bullet_sprite.visible = true
            missile_sprite.visible = false
            bomb_sprite.visible = false

        1:
            bullet_sprite.visible = false
            missile_sprite.visible = true
            bomb_sprite.visible = false
        2:
            bullet_sprite.visible = false
            missile_sprite.visible = false
            bomb_sprite.visible = true


func sprite_rotation(angle: float):
    match projectile_type:
        ProjectileType.BULLET:
            bullet_sprite.rotation = angle
        ProjectileType.MISSILE:
            missile_sprite.rotation = angle
        ProjectileType.BOMB:
            bomb_sprite.rotation = angle
