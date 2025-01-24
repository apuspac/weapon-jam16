extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
    var goal = get_node("../../Goal")
    goal.notice_hit_goal.connect(self._on_hit_goal)

    visible = false


func _on_hit_goal():
    print_debug("goal_hit")
    visible = true