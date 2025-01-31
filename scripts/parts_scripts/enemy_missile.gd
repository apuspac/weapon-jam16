extends Enemy

# bullet: 0, missile: 1, bomb: 2
var enemy_id : int = 1

func _ready():
    super._ready()

func _on_enemy_area_body_entered(_body: Node2D):
    super._on_enemy_area_body_entered(_body)
    notice_hit_enemy.emit(enemy_id)