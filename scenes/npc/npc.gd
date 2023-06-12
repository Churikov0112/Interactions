extends Interactable

var QuestInterface = preload("res://dialogs/quest_interface.gd")

func _ready():
	print("dummy npc is ready")


func _process(delta):
	pass

# interactable
func get_interaction_text():
	return "поговорить с NPC1" # с маленькой буквы

func interact():
	QuestInterface.start_dialog("res://dialogs/npc1.dialogue", "start")
