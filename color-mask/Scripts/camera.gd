extends Camera2D
class_name ShaderCamera

# Store the shader material
@onready var shader_material: ShaderMaterial = $CanvasLayer/ColorRect.material

# Define presets as dictionaries
var presets = {
	GlobalStateClass.MaskState.Full: {
		"show_reds": true,
		"show_oranges": true,
		"show_yellows": true,
		"show_greens": true,
		"show_cyans": true,
		"show_blues": true,
		"show_magentas": true,
		"red_saturation": 1.0,
		"orange_saturation": 1.0,
		"yellow_saturation": 1.0,
		"green_saturation": 1.0,
		"cyan_saturation": 1.0,
		"blue_saturation": 1.0,
		"magenta_saturation": 1.0
	},
	GlobalStateClass.MaskState.Grey: {
		"show_reds": false,
		"show_oranges": false,
		"show_yellows": false,
		"show_greens": false,
		"show_cyans": false,
		"show_blues": false,
		"show_magentas": false,
		"red_saturation": 0.0,
		"orange_saturation": 0.0,
		"yellow_saturation": 0.0,
		"green_saturation": 0.0,
		"cyan_saturation": 0.0,
		"blue_saturation": 0.0,
		"magenta_saturation": 0.0
	},
	GlobalStateClass.MaskState.One: {
		"show_reds": false,
		"show_oranges": false,
		"show_yellows": false,
		"show_greens": true,
		"show_cyans": true,
		"show_blues": false,
		"show_magentas": false,
		"red_saturation": 1.0,
		"orange_saturation": 1.0,
		"yellow_saturation": 1.0,
		"green_saturation": 1.0,
		"cyan_saturation": 1.0,
		"blue_saturation": 1.0,
		"magenta_saturation": 1.0
	},
	
}

func _ready():
	add_to_group("camera")
	apply_preset(GlobalStateClass.MaskState.Full)

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
		
		# Only tween numeric values
		if typeof(target_value) == TYPE_FLOAT or typeof(target_value) == TYPE_INT:
			tween.tween_method(
				func(value): shader_material.set_shader_parameter(param_name, value),
				current_value,
				target_value,
				duration
			)
		else:
			# Immediately set booleans
			shader_material.set_shader_parameter(param_name, target_value)
