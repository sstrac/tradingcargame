extends Node

signal score_changed

var score = 0:
	set(s):
		score = s
		score_changed.emit()
