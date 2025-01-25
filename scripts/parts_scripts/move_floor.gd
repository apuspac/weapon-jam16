extends AnimatableBody2D

var animation_player

func _ready():
    if has_node("AnimationPlayer") == true:
        animation_player = get_node("AnimationPlayer")
        animation_player.play("move")
        print_debug("AnimationPlayer found")
    else:
        print_debug("AnimationPlayer not found")

