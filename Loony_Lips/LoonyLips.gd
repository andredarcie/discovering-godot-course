extends Control

onready var DisplayText = $VBoxContainer/DisplayText
onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText

var player_words = []
var current_story = {
	"prompts": [],
	"story": ""
}

func _ready():
	pick_current_story()
	DisplayText.text = "Welcome to Loony Lips! We're going to tell a story and have a wonderful time!"
	check_player_words_length()
	PlayerText.grab_focus()


func pick_current_story():
	randomize()
	get_from_nodes()


func get_from_json(filename):
	var file = File.new()
	file.open(filename, File.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	current_story = data[randi() % data.size()]
	

func get_from_nodes():
	var stories = $StoryBook.get_child_count()
	var selected_story = randi() % stories
	current_story.prompts = $StoryBook.get_child(selected_story).prompts
	current_story.story = $StoryBook.get_child(selected_story).story
	
	
func _on_PlayerText_text_entered(new_text):
	add_to_player_words()


func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		add_to_player_words()
	
	
func add_to_player_words():
	player_words.append(PlayerText.text)
	DisplayText.text = ""
	PlayerText.clear()
	check_player_words_length()
	
	
func is_story_done():
	return player_words.size() == current_story.prompts.size()
	
	
func check_player_words_length():
	if is_story_done():
		end_game()
	else:
		prompt_player()
		
		
func tell_story():
	DisplayText.text = current_story.story % player_words
	
	
func prompt_player():
	DisplayText.text += "May I have " + current_story.prompts[player_words.size()] + " please?"
	
	
func end_game():
	PlayerText.queue_free()
	$VBoxContainer/HBoxContainer/Label.text = "Again! "
	tell_story()
