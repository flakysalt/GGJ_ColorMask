extends StaticBody2D

@export var dialogues: Dictionary[String,DialogueCommand]
@export var dialogue: DialogueCommand

func interact():
	for state_key in dialogues:
		if GlobalState.hasState(state_key):
			continue
		var command: DialogueCommand = dialogues[state_key]
		command.execute(self)
