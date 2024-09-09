extends Area2D

@onready var timer: Timer = $Timer

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print("Died")
	timer.start()



func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
