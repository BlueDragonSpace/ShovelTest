extends Node

signal score_changed()
var SCORE = 0:
    set(value):
        SCORE = value
        emit_signal("score_changed")

signal call_restart()
func restart():
    is_player_hit = false
    SCORE = 0
    emit_signal("call_restart")

var is_player_hit = false
signal call_player_hit()
func player_hit(): 
    is_player_hit = true
    emit_signal("call_player_hit")