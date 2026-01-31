extends CanvasLayer

@export var camera : Camera2D

func _ready() -> void:
	for i in GlobalStateClass.MaskState:
		
		pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		visible = !visible
		
func on_color_button_pressed():
	pass

func _on_color_button_pressed() -> void:
	camera.transition_to_preset(GlobalStateClass.MaskState.Full)
func _on_grey_button_pressed() -> void:
	camera.transition_to_preset(GlobalStateClass.MaskState.Grey)
