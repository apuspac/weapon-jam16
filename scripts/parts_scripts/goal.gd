extends Node2D

signal notice_hit_goal()


# Called when the node enters the scene tree for the first time.
func _ready():
    var goal_area = get_node("Area2D")
    goal_area.body_entered.connect(self._on_goal_area_body_entered)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    pass

func _on_goal_area_body_entered(_body: Node2D):
    print_debug("goal hit")
    notice_hit_goal.emit()
    # queue_free()