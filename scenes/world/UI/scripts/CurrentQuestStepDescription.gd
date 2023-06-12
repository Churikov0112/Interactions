extends Label

@onready var current_quest_step_description = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quest_interface_step_started(step):
	print(step)
	if step["step_type"] == "incremental_step":
		var format_string = "%s %d/%d"
		var actual_string = format_string % [step["details"], step["collected"], step["required"]]
		print(actual_string)
		current_quest_step_description.text = actual_string
#	print(step)
