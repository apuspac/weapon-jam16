extends Node2D

signal notice_on_pause_menu()
signal notice_off_pause_menu()


var is_paused: bool = false
var is_stage_cleared: bool = false

func _ready():
    var goal = get_node("Goal")
    goal.notice_hit_goal.connect(self._on_stage_cleared)

    var killzone = get_node("Killzone")
    killzone.notice_end_killtimer.connect(self._on_end_killtimer)

    var pause_menu = get_node("CanvasLayer/PauseMenu")
    pause_menu.notice_resume_game.connect(self.handle_pause_menu)

func _process(_delta):
    if Input.is_action_just_pressed("A_button"):
        stage_cleared()

    if Input.is_action_just_pressed("pause_button"):
        handle_pause_menu()

func handle_pause_menu():
    is_paused = !is_paused

    if is_paused:
        notice_on_pause_menu.emit()
        Engine.time_scale = 0
    else:
        notice_off_pause_menu.emit()
        Engine.time_scale = 1







func _input(_event: InputEvent):
    if is_stage_cleared and _event is InputEventMouseButton:
        print_debug("next stage")
        stage_cleared()

func stage_cleared():
    # stage名はstage1, stage2 としてください
    var next_stage_int: int = self.name.substr(5).to_int() + 1
    var next_stage: String = "stage" + str(next_stage_int) + ".tscn"

    # 10ステージだった場合 endに遷移
    if next_stage_int > 9:
        get_tree().change_scene_to_file("res://scenes/end.tscn")
    else:
        get_tree().change_scene_to_file("res://scenes/" + next_stage)

func _on_stage_cleared():
    is_stage_cleared = true



func _on_end_killtimer():
    get_tree().reload_current_scene()
