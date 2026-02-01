extends DialogueCommand
class_name ContinueConversationCommand

@export_multiline var text: String
@export var speaker : String
@export var next_conversation: DialogueCommand

func execute(caller : Node) -> void:
	var ui_system : UiSystem = caller.get_tree().get_first_node_in_group("ui_system")
	ui_system.show_dialogue(self,caller)
	
	var player : PlayerCharacter = caller.get_tree().get_first_node_in_group("player")
	player.state = PlayerCharacter.State.Conversation
