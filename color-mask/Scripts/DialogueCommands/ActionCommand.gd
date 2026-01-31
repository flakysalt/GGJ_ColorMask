extends DialogueCommand
class_name ActionCommand

@export var followupCommand: DialogueCommand

func execute(caller : Node) -> void:
	print("This is an action")
