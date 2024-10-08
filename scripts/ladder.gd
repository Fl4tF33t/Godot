extends Area2D

var player: Player

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body as Player
		player.is_on_ladder = true

func _on_body_exited(body: Node2D) -> void:
	if player != null:
		player.is_on_ladder = false
