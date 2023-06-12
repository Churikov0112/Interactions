extends Node

class_name QuestInterface

signal step_started(step)

static func start_dialog(resource: String, title: String):
	if !State.is_player_talking:
		DialogueManager.show_example_dialogue_balloon(load(resource), title)
		
func start_quest(resource: String, quest_name: String):
	var quest_resource = load(resource)
	QuestManager.add_quest_from_resource(quest_resource, quest_name)
	var current_step = QuestManager.get_current_step(quest_name)
	emit_signal("step_started", current_step)
	
#func progress_quest(resource: String, quest_name: String):
#	var quest_resource = load(resource)
#	QuestManager.set_quest_step_items(quest_name:String,quest_item:String,amount:int=0,collected:bool=false)
#	var current_step = QuestManager.get_current_step(quest_name)
#	emit_signal("step_started", current_step)
