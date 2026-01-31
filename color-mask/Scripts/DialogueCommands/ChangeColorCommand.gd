extends DialogueCommand
class_name ChangeColorCommand

@export var shaderPresetName : GlobalStateClass.MaskState
@export var transitionTime : float = 3

func execute(caller : Node) -> void:
	var camera : ShaderCamera = caller.get_tree().get_first_node_in_group("camera")
	camera.transition_to_preset(shaderPresetName,transitionTime)
	GlobalState.currentMaskState = shaderPresetName
