extends DialogueCommand
class_name SetGlobalStateCommand

@export var id : String

func execute(caller : Node) -> void:
	GlobalState.addToState(id)
