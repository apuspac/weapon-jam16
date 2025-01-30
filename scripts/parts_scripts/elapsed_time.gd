extends Control
var start_time: float = 0.0

func _ready():
    visible = true

    if has_node("../../Goal"):
        var goal = get_node("../../Goal")
        goal.notice_hit_goal.connect(self._on_hit_goal)


func _process(_delta):
    start_time += _delta
    self.text = time_to_string(start_time)

func _on_hit_goal():
    visible = false


func time_to_string(stage_time) -> String:

    var milliseconds =  fmod(stage_time, 1) * 1000
    var sec = fmod(stage_time, 60)
    var minsec = stage_time / 60

    var format_string = "%02d:%02d:%03d" % [minsec, sec, milliseconds]

    return format_string
