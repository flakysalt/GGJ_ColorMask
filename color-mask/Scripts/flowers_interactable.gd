extends Node2D

@export var finishDialogue: DialogueCommand

func _on_flowers_on_interacted() -> void:
	for child in get_children():
		var flower : FlowerInteractable = child
		if !flower.interactedWith:
			return
		finishDialogue.execute(self)
