extends Control

onready var displayText = $VBoxContainer/DisplayText
onready var playerText = $VBoxContainer/PlayerText

func _ready():
	var prompts = ["Yann", "Minions", "greatest"]
	var story = "Once upon a time %s watched %s and thought it was the %s movie of the past two decades"
	displayText.text = story % prompts


func _on_PlayerText_text_entered(new_text):
	update_DisplayText(new_text)


func update_DisplayText(words: String):
	displayText.text = words
	playerText.clear()
