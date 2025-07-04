extends Control

@onready var score_label : Label = $SCORE
var shown_score : int = 0 # The score displayed on the UI, for animation of the number

func _ready():
    # Connect the score_changed signal to update the score label
    GlobalVars.connect("score_changed", _on_score_changed)
    _on_score_changed(GlobalVars.SCORE)  # Initialize the label with the current score

    GlobalVars.connect("call_player_hit", _on_player_hit)

func _on_score_changed(new_score):
    score_label.text = str(new_score)

func _process(_delta):
    # Smoothly update the shown score to match the actual score
    if shown_score != GlobalVars.SCORE:
        if shown_score < GlobalVars.SCORE:
            shown_score += 1
        elif shown_score > GlobalVars.SCORE:
            shown_score -= 10
    score_label.text = "SCORE: " + str(shown_score)

func _on_retry_pressed():
    $RETRY.visible = false
    GlobalVars.restart()

func _on_player_hit():
    $RETRY.visible = true