extends Projectile


func _ready():
    # projectile.gdの_read()
    super._ready()

func flight(_delta):
    velocity = direction * speed
    move_and_slide()

func fire(target_position: Vector2):
    # 横方向を制限するには..? directionの範囲を-45 ~ 45度に制限すればよいか
    super.fire(target_position)
    speed = 2000

    # NOTE: 実装するかは保留
    # var angle = direction.angle()
    # if angle > 2/PI:
    #     angle = 2/PI
    # elif angle < -2 / PI:
    #     angle = -2 / PI

    # direction = Vector2(cos(angle), sin(angle))
    # print(angle)

