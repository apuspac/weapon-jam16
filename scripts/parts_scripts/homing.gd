extends Projectile

var stamina: float = 100.0

func _ready():
    super._ready()


func flight(_delta):
    if stamina > 0:
        var mouse_position = get_global_mouse_position()
        var _direction = (mouse_position - position).normalized()
        position += _direction * speed * _delta
    else:
        change_state(States.FALLDOWN)

    # print(stamina)
    stamina -= 1.0

func fire(target_position: Vector2):
    super.fire(target_position)
    speed = 750
    stamina = 100.0