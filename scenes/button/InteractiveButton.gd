extends Interactable

enum STATE {
	ON,
	OFF
}
@onready var state = STATE.OFF
@onready var quest_interface = $"../quest_interface"
@onready var anim_player = $AnimationPlayer
@onready var audio_player = $AudioStreamPlayer3D
signal on_state_changed

# interactable
func get_interaction_text():
	if state == STATE.ON:
		return "to turn off"

	return "to turn on"

func interact():
	# return if button is in mid animation
	if anim_player.is_playing():
		return
		
	if state == STATE.ON:
		State.active_lights_count=State.active_lights_count-1
		turn_off()
	else:
		State.active_lights_count=State.active_lights_count+1
		turn_on()
	
	if State.get_active_quest_step_details() == "Включите все фонари на этой локации":
		quest_interface.set_quest_step_items("res ://quests/lamp_quest.quest", "Ламповый квест", "Свет", State.active_lights_count, State.active_lights_count >= 2)
		if State.active_lights_count==2:
			quest_interface.progress_quest("res ://quests/lamp_quest.quest", "Ламповый квест", "Свет", State.active_lights_count, State.active_lights_count >= 2)
			

# button
func turn_on():
	# return if button is in mid animation
	if anim_player.is_playing():
		return

	if state == STATE.ON:
		return

	state = STATE.ON
	anim_player.play("button_on")
	audio_player.play()

func turn_off():
	# return if button is in mid animation
	if anim_player.is_playing():
		return

	if state == STATE.OFF:
		return

	state = STATE.OFF
	anim_player.play_backwards("button_on")
	audio_player.play()

func _on_AnimationPlayer_animation_finished(_anim_name):
	if state == STATE.ON:
		emit_signal("on_state_changed", true)
	else:
		emit_signal("on_state_changed", false)
