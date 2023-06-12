extends RayCast3D

var current_collider

@onready var interaction_label = get_node("/root/World/UI/InteractionLabel") as Label

func _ready():
	set_interaction_text("")
	

func _process(delta):
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		if current_collider!=collider:
			set_interaction_text((collider.get_interaction_text()))
			current_collider = collider
			
		if Input.is_action_just_pressed("interact"):
			collider.interact()
			set_interaction_text(collider.get_interaction_text())
	elif current_collider:
		set_interaction_text("")
		current_collider = null
		
func set_interaction_text(text):
	if text == "":
		interaction_label.set_text("")
		interaction_label.set_visible(false)
	else: 
		var interact_key = InputMap.action_get_events("interact")[0].as_text()
		interaction_label.set_text("Нажмите %s чтобы %s" % [interact_key, text])
		interaction_label.set_visible(true)
