extends Projectile

var stamnina

func _ready():
    # projectile.gdの_read()
    super._ready()


func flight(_delta):
    var mouse_position = get_global_mouse_position()
    var direction = (mouse_position - position).normalized()
    position += direction * speed * _delta


    # position = position.move_toward(kjget_global_mouse_position(), speed * _delta)

func fire(target_position: Vector2):
    super.fire(target_position)
    speed = 200