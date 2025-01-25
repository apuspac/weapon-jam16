extends Projectile

var bomb_gravity : Vector2 = Vector2(0, 750)
var rotate_angle : float = 0.0

func flight(_delta):
    velocity += bomb_gravity * _delta
    move_and_slide()
    sprite_rotation(rotate_angle)
    rotate_angle += 0.1



func fire(target_position: Vector2):
    super.fire(target_position)
    var mouse_distance = (target_position - global_position).length()
    print(mouse_distance)
    speed = mouse_distance * 3.5
    velocity = direction * speed

    rotate_angle = direction.angle()
    print_debug(direction.angle())


