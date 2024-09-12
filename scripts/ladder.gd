extends Area2D

func _on_body_entered(body: Node2D) -> void:
	var script = body.get_script()
	if script:
		var player = script as Player
		if player:
			player.is_on_ladder = true
