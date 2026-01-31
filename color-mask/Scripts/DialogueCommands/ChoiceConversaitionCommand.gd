extends DialogueCommand
class_name ChoiceConversationCommand

@export_multiline var text: String
@export var speaker : String

@export var button1text: String
@export var button1followup: DialogueCommand
@export var button2text: String
@export var button2followup: DialogueCommand
@export var button3text: String
@export var button3followup: DialogueCommand

func execute(caller : Node) -> void:
	var ui_system : UiSystem = caller.get_tree().get_first_node_in_group("ui_system")
	ui_system.show_dialogue(self)
	
