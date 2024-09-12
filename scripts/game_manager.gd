extends Node

@onready var score_label: Label = $Label
signal on_score_change(value: int)

var score:= 0

func add_point(amount: int):
	score += amount
	on_score_change.emit(score)
	score_label.text = "Score: " + str(score)
