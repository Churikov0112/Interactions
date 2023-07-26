extends Node

class_name QuestInterface

signal step_updated(step)
signal quest_completed

static func start_dialog(resource: String, title: String):
	if !State.is_player_talking:
		DialogueManager.show_example_dialogue_balloon(load(resource), title)
		
func start_quest(resource: String, quest_name: String):
	var quest_resource = load(resource)
	QuestManager.add_quest_from_resource(quest_resource, quest_name)
	State.active_quest_name = quest_name
	var current_step = QuestManager.get_current_step(quest_name)
	emit_signal("step_updated", current_step)

func set_quest_step_items(resource: String, quest_name: String, quest_item:String="", amount:int=1, collected:bool=true):
	var quest_resource = load(resource)
	QuestManager.set_quest_step_items(quest_name, quest_item, amount, collected)
	var current_step = QuestManager.get_current_step(quest_name)
	emit_signal("step_updated", current_step)
	
func progress_quest(resource: String, quest_name: String, quest_item:String="", amount:int=1, completed:bool=true):
	QuestManager.progress_quest(quest_name, quest_item, amount, completed)
	var current_step = QuestManager.get_current_step(quest_name)
	emit_signal("step_updated", current_step)
	
func complete_quest(quest_name:String):
	QuestManager.complete_quest(quest_name)
	State.active_quest_name = ""
	emit_signal("quest_completed")
	
static func is_quest_complete(quest_name:String) -> bool:
	return QuestManager.is_quest_complete(quest_name)

