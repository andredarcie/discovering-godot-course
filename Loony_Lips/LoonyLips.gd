extends Control

func _ready():
	var prompts = ["Yann", "Minions", "greatest"]
	var story = "Once upon a time %s watched %s and thought it was the %s movie of the past two decades"
	print(story % prompts)
