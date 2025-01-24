extends Area2D
signal notice_enter_killzone()
signal notice_end_killtimer()
@onready var killzone_timer = get_node("Timer")

func _ready():
    self.body_entered.connect(self._on_kill_zone_body_entered)
    killzone_timer.timeout.connect(self._on_killtimer_timeout)


func _on_kill_zone_body_entered(_body: Node2D):
    notice_enter_killzone.emit()
    killzone_timer.start()


func _on_killtimer_timeout():
    notice_end_killtimer.emit()