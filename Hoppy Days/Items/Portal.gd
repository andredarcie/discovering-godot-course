extends Node2D


func _ready():
	pass


func _on_Area2D_body_entered(body):
	get_tree().call_group("Gamestate", "win_game")
