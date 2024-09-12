extends Area2D

@export var destination: Node2D
var player: Player

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body as Player
		player.position = destination.transform.origin
