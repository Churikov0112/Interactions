extends Node

var is_player_talking: bool = false

var active_quest_name: String = ""

func get_active_quest_step_details():
	if active_quest_name == "":
		return ""
	return QuestManager.get_current_step(active_quest_name)["details"]
	
# Ламповый квест ----------------------------------------------------

var active_lights_count: int = 0
