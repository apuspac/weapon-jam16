extends Enemy

var enemy_floor
var animation_floor

func _ready():
    super._ready()
    enemy_floor = get_node("MoveFloor")
    animation_floor = get_node("../AnimationPlayer")
    animation_floor.play("RESET")
    animation_floor.play("move")

func _on_enemy_area_body_entered(_body: Node2D):
    super._on_enemy_area_body_entered(_body)
    enemy_floor.queue_free()
