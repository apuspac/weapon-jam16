extends Node2D

func _ready():
    pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if Input.is_action_just_pressed("A_button"):
        stage_cleared()


func stage_cleared():
    print_debug("next stage")
    var next_stage_int: int = self.name.substr(5).to_int() + 1
    var next_stage: String = "stage" + str(next_stage_int) + ".tscn"

    if next_stage_int > 9:
        get_tree().change_scene_to_file("res://scenes/end.tscn")
    else:
        get_tree().change_scene_to_file("res://scenes/" + next_stage)
