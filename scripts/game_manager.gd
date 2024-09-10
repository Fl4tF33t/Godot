extends Node

@onready var score_label: Label = $Label

var score:= 0

func add_point(amount: int):
	score += amount
	score_label.text = "Score: " + str(score)
