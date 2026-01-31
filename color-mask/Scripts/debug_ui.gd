extends CanvasLayer

@export var camera : Camera2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		visible = !visible

func _on_color_button_pressed() -> void:
	camera.transition_to_preset("all_colors")
func _on_grey_button_pressed() -> void:
	camera.transition_to_preset("grayscale")
