class_name Enemy
extends Node2D

signal notice_hit_enemy()

@onready var explosion = get_node("Explosion")
@onready var sprite = get_node("Sprite2D")

func _ready():
    var enemy_area = get_node("Area2D")
    enemy_area.body_entered.connect(self._on_enemy_area_body_entered)

    explosion.animation_finished.connect(self.queue_free)


func _process(_delta):
    pass

func _on_enemy_area_body_entered(_body: Node2D):
    # print_debug("bullet hit")
    explosion.play("explosion")
    sprite.visible = false
    notice_hit_enemy.emit()
    # queue_free()
