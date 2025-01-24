extends Node2D

signal notice_hit_enemy()


# Called when the node enters the scene tree for the first time.
func _ready():
    var enemy_area = get_node("Area2D")
    enemy_area.body_entered.connect(self._on_enemy_area_body_entered)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    pass

func _on_enemy_area_body_entered(_body: Node2D):
    print_debug("bullet hit")
    notice_hit_enemy.emit()
    queue_free()