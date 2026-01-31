extends DialogueCommand
class_name CloseConversationCommand

@export var followupCommand: DialogueCommand

func execute(caller : Node) -> void:
	var ui_system : UiSystem = caller.get_tree().get_first_node_in_group("ui_system")
	ui_system.close_conversation()
