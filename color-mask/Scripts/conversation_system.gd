extends Control
class_name UiSystem

var nextCommand : DialogueCommand

var button1Command : DialogueCommand
var button2Command : DialogueCommand
var button3Command : DialogueCommand

@export var button1 : AutoSizeButton
@export var button2 : AutoSizeButton
@export var button3 : AutoSizeButton

func _ready() -> void:
	add_to_group("ui_system")

func show_dialogue(command: DialogueCommand):
	visible = true
	$AnimationPlayer.stop()

	$VBoxContainer/AnsweButtons.visible = false
	if(command is ChoiceConversationCommand):
		$VBoxContainer/AnsweButtons.visible = true
		nextCommand = null
		button1Command = command.button1followup
		button2Command = command.button2followup
		button3Command = command.button3followup
		button1.button_text = command.button1text
		button2.button_text = command.button2text
		button3.button_text = command.button3text

		button1.visible = command.button1followup != null
		button2.visible = command.button2followup != null
		button3.visible = command.button3followup != null
		$VBoxContainer/RichTextLabel.text= command.text
		$VBoxContainer/Label.text = command.speaker
		$AnimationPlayer.play("DisplayText")
	pass
	
	if(command is ContinueConversationCommand):
		nextCommand = command.next_conversation
		$VBoxContainer/RichTextLabel.text= command.text
		$AnimationPlayer.play("DisplayText")
		$VBoxContainer/Label.text = command.speaker
	pass

func close_conversation():
	#make player move again
	visible =false
	
func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if $AnimationPlayer.is_playing():
			$AnimationPlayer.seek($AnimationPlayer.current_animation_length, true)
			return
		if nextCommand != null:
			nextCommand.execute(self)

func _on_button_pressed() -> void:
	button1Command.execute(self)
func _on_button_2_pressed() -> void:
	button2Command.execute(self)
func _on_button_3_pressed() -> void:
	button3Command.execute(self)
