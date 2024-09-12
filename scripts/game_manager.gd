extends Node

@onready var score_label: Label = $Label
signal on_score_change(value: int)

var _coin_score: int = 0
var Score : int :
	get:
		return _coin_score
	set(value):
		_coin_score += value
		on_score_change.emit(Score)
