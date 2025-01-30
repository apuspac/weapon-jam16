extends Enemy

var enemy_floor

func _ready():
    super._ready()
    enemy_floor = get_node("MoveFloor")

func _on_enemy_area_body_entered(_body: Node2D):
    super._on_enemy_area_body_entered(_body)
    enemy_floor.visible = false