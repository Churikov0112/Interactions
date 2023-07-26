extends Label

@onready var current_quest_step_description = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quest_interface_step_updated(step):
	print(step)
	if step["step_type"] == "action_step":
		current_quest_step_description.text = step["details"]
	if step["step_type"] == "incremental_step":
		var format_string = "%s %d/%d"
		var actual_string = format_string % [step["details"], step["collected"], step["required"]]
		print(actual_string)
		current_quest_step_description.text = actual_string


func _on_quest_interface_quest_completed():
	current_quest_step_description.text = ""
