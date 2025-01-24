extends Node2D

var is_stage_cleared: bool = false

func _ready():
    var goal = get_node("Goal")
    goal.notice_hit_goal.connect(self._on_stage_cleared)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if Input.is_action_just_pressed("A_button"):
        stage_cleared()

func _on_stage_cleared():
    is_stage_cleared = true


func _input(_event: InputEvent):
    if is_stage_cleared and _event is InputEventMouseButton:
        print_debug("next stage")
        stage_cleared()

func stage_cleared():
    var next_stage_int: int = self.name.substr(5).to_int() + 1
    var next_stage: String = "stage" + str(next_stage_int) + ".tscn"

    if next_stage_int > 9:
        get_tree().change_scene_to_file("res://scenes/end.tscn")
    else:
        get_tree().change_scene_to_file("res://scenes/" + next_stage)
