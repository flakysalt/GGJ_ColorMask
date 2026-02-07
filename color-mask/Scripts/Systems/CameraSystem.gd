extends Camera2D
class_name ShaderCamera

# Store the shader material
@onready var shader_material: ShaderMaterial = $CanvasLayer/ColorRect.material

# Define presets as dictionaries
var presets = {
	GlobalStateClass.MaskState.Full: {
		"red_saturation": 1.0,
		"orange_saturation": 1.0,
		"yellow_saturation": 1.0,
		"green_saturation": 1.0,
		"cyan_saturation": 1.0,
		"blue_saturation": 1.0,
		"magenta_saturation": 1.0
	},
	GlobalStateClass.MaskState.Grey: {
		"red_saturation": 0.0,
		"orange_saturation": 0.0,
		"yellow_saturation": 0.0,
		"green_saturation": 0.0,
		"cyan_saturation": 0.0,
		"blue_saturation": 0.0,
		"magenta_saturation": 0.0
	},
	GlobalStateClass.MaskState.One: {
		"red_saturation": 0.0,
		"orange_saturation": 0.0,
		"yellow_saturation": 0.1,
		"green_saturation": 0.2,
		"cyan_saturation": 0.0,
		"blue_saturation": 0.0,
		"magenta_saturation": 0.0
	},
	GlobalStateClass.MaskState.Two: {
		"red_saturation": 0.0,
		"orange_saturation": 0.0,
		"yellow_saturation": 0.1,
		"green_saturation": 0.2,
		"cyan_saturation": 0.2,
		"blue_saturation": 0.1,
		"magenta_saturation": 0.0
	},
	GlobalStateClass.MaskState.Three: {
		"red_saturation": 0.0,
		"orange_saturation": 0.1,
		"yellow_saturation": 0.1,
		"green_saturation": 0.2,
		"cyan_saturation": 0.2,
		"blue_saturation": 0.1,
		"magenta_saturation": 0.3
	},
	GlobalStateClass.MaskState.Four: {
		"red_saturation": 0.3,
		"orange_saturation": 0.35,
		"yellow_saturation": 0.1,
		"green_saturation": 0.2,
		"cyan_saturation": 0.2,
		"blue_saturation": 0.1,
		"magenta_saturation": 0.3
	},
	GlobalStateClass.MaskState.Five: {
		"red_saturation": 0.3,
		"orange_saturation": 0.35,
		"yellow_saturation": 0.1,
		"green_saturation": 0.2,
		"cyan_saturation": 0.45,
		"blue_saturation": 0.4,
		"magenta_saturation": 0.3
	},
	GlobalStateClass.MaskState.Six: {
		"red_saturation": 0.4,
		"orange_saturation": 0.5,
		"yellow_saturation": 0.1,
		"green_saturation": 0.2,
		"cyan_saturation": 0.45,
		"blue_saturation": 0.4,
		"magenta_saturation": 0.6
	},
	GlobalStateClass.MaskState.Seven: {
		"red_saturation": 0.4,
		"orange_saturation": 0.5,
		"yellow_saturation": 0.3,
		"green_saturation": 0.4,
		"cyan_saturation": 0.6,
		"blue_saturation": 0.4,
		"magenta_saturation": 0.6
	},
	GlobalStateClass.MaskState.Eight: {
		"red_saturation": 0.6,
		"orange_saturation": 0.5,
		"yellow_saturation": 0.6,
		"green_saturation": 0.4,
		"cyan_saturation": 0.6,
		"blue_saturation": 0.4,
		"magenta_saturation": 0.8
	},
	GlobalStateClass.MaskState.Nine: {
		"red_saturation": 0.6,
		"orange_saturation": 0.5,
		"yellow_saturation": 0.6,
		"green_saturation": 0.7,
		"cyan_saturation": 0.8,
		"blue_saturation": 0.7,
		"magenta_saturation": 0.8
	},
	GlobalStateClass.MaskState.Ten: {
		"red_saturation": 0.8,
		"orange_saturation": 0.8,
		"yellow_saturation": 0.8,
		"green_saturation": 0.7,
		"cyan_saturation": 0.8,
		"blue_saturation": 0.7,
		"magenta_saturation": 0.8
	},
	GlobalStateClass.MaskState.Eleven: {
		"red_saturation": 0.8,
		"orange_saturation": 0.8,
		"yellow_saturation": 0.8,
		"green_saturation": 0.8,
		"cyan_saturation": 0.8,
		"blue_saturation": 0.8,
		"magenta_saturation": 0.8
	},
}

func _ready():
	add_to_group("camera")
	apply_preset(GlobalState.currentMaskState)

# Apply a preset by name
func apply_preset(preset_name: GlobalStateClass.MaskState):
	if not presets.has(preset_name):
		push_error("Preset '%s' not found!" % preset_name)
		return
	
	var preset = presets[preset_name]
	for param_name in preset.keys():
		shader_material.set_shader_parameter(param_name, preset[param_name])

# Example: gradually transition between presets
func transition_to_preset(preset_name: GlobalStateClass.MaskState, duration: float = 1.0):
	if not presets.has(preset_name):
		push_error("Preset '%s' not found!" % preset_name)
		return
	
	var target_preset = presets[preset_name]
	var tween = create_tween()
	tween.set_parallel(true)
	
	for param_name in target_preset.keys():
		var current_value = shader_material.get_shader_parameter(param_name)
		var target_value = target_preset[param_name]
		
		tween.tween_method(
			func(value): shader_material.set_shader_parameter(param_name, value),
			current_value,
			target_value,
			duration).set_trans(Tween.TRANS_ELASTIC)
