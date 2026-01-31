extends StaticBody2D

@export var dialogue : DialogueCommand

func interact():
	dialogue.execute(self)
