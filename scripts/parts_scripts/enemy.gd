class_name Enemy
extends Node2D

signal notice_hit_enemy(enemy_id : int)

@onready var explosion = get_node("Explosion")
@onready var sprite = get_node("Sprite2D")
@onready var explosion_sfx = get_node("ExplosionSFX")
@onready var queue_free_timer = get_node("Timer")

var enemy_floor
var animation_floor

func _ready():
    var enemy_area = get_node("Area2D")
    enemy_area.body_entered.connect(self._on_enemy_area_body_entered)

    explosion.animation_finished.connect(self.queue_free)


    if has_node("MoveFloor") == true:
        enemy_floor = get_node("MoveFloor")

        if has_node("../AnimationPlayer") == true:
            animation_floor = get_node("../AnimationPlayer")
            animation_floor.play("RESET")
            animation_floor.play("move")

func _process(_delta):
    pass

func _on_enemy_area_body_entered(_body: Node2D):
    if enemy_floor != null:
        enemy_floor.visible = false

    explosion.play("explosion")
    sprite.visible = false
    # notice_hit_enemy.emit()
    explosion_sfx.play()