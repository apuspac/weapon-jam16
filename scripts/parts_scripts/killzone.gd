extends Area2D
signal notice_enter_killzone()


func _ready():
    self.body_entered.connect(self._on_kill_zone_body_entered)


func _on_kill_zone_body_entered(_body: Node2D):
    print_debug("kill zone enterd")
    notice_enter_killzone.emit()
    # queue_free()
