extends DialogueCommand
class_name PlayAnimationCommand

@export var anim_name : String
@export var followupCommand: DialogueCommand

func execute(caller : Node) -> void:
	if caller.has_method("play_animation"):
		caller.play_animation(anim_name)
	else:
		printerr("missing animation on ", caller.name)
		
	if followupCommand != null:
		followupCommand.execute(caller)
	pass
	
