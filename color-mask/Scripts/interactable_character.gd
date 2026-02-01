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
		return

func play_animation(animation_name : String):
	animationPlayer.play(animation_name)
