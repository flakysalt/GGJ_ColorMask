extends DialogueCommand
class_name SetGlobalStateCommand

@export var id : String
@export var followupCommand: DialogueCommand


func execute(caller : Node) -> void:
	GlobalState.addToState(id)
			
	if followupCommand != null:
		followupCommand.execute(caller)
