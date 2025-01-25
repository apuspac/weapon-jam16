extends Projectile

var bomb_gravity : Vector2 = Vector2(0, 750)

func flight(_delta):
    velocity += bomb_gravity * _delta
    move_and_slide()

func fire(target_position: Vector2):
    super.fire(target_position)
    var mouse_distance = (target_position - global_position).length()
    print(mouse_distance)
    speed = mouse_distance * 3.5
    velocity = direction * speed


