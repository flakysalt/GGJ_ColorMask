extends StaticBody2D
class_name FlowerInteractable

signal on_interacted

@export var command: DialogueCommand
@export var keyToBeActive : String
var interactedWith : bool

func _ready() -> void:
	if GlobalState.currentMaskState >= 3:
		interactedWith = true

func interact():
	if GlobalState.hasState(keyToBeActive) && !interactedWith:
		command.execute(self)
		interactedWith = true
