extends Node2D

@export var initicalConversation : DialogueCommand
@export var state_to_skip = "initialSkip"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !GlobalState.hasState(state_to_skip):
		GlobalState.addToState(state_to_skip)
		initicalConversation.execute(self)
