extends Node

signal score_changed()
var SCORE = 0:
    set(value):
        SCORE = value
        emit_signal("score_changed")

signal call_restart()
func restart():
    emit_signal("call_restart")

signal call_player_hit()
func player_hit(): 
    emit_signal("call_player_hit")