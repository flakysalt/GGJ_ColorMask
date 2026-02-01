extends StaticBody2D


#DONT USE THE DICT, doesnt save order
@export var dialogues: Dictionary[String,DialogueCommand]
@export var dialogueList : Array[DialogueWithKey]

@export var animationPlayer : AnimationPlayer

func interact():
	for entry in dialogueList:
		if GlobalState.hasState(entry.key):
			continue
		entry.command.execute(self)
	
	for state_key in dialogues:
		if GlobalState.hasState(state_key):
			continue
		var command: DialogueCommand = dialogues[state_key]
		command.execute(self)

func play_animation(animation_name : String):
	animationPlayer.play(animation_name)
