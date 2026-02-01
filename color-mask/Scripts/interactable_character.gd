extends StaticBody2D

@export var dialogues: Dictionary[String,DialogueCommand]
@export var dialogue: DialogueCommand

@export var animationPlayer : AnimationPlayer

func interact():
	for state_key in dialogues:
		if GlobalState.hasState(state_key):
			continue
		var command: DialogueCommand = dialogues[state_key]
		command.execute(self)

func play_animation(animation_name : String):
	animationPlayer.play(animation_name)
