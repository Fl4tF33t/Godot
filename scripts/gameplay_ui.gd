extends CanvasLayer

@onready var game_manager: Node = %GameManager

# Time variables
var time: float = 0
var time_is_active:= false

func _ready() -> void:
	game_manager.on_score_change.connect(track_score)
	time_is_active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	track_time(delta)

# Handle in game timer
func track_time(delta: float) -> void:
	
	if not time_is_active:
		time = 0
		return

	time += delta  # Increment the timer by the time elapsed since the last frame
	var minutes = int(time) / 60  # Calculate the number of minutes
	var seconds = int(time) % 60  # Calculate the remaining seconds
	var formatted_time = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)  # Format as MM:SS
	$Timer.text = formatted_time

func track_score(score: int) -> void:
	$Coin.text = "Score: " + str(score)
