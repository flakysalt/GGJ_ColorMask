extends CanvasLayer

@export var camera : Camera2D
@onready var container = $VBoxContainer

func _ready() -> void:
	for state in GlobalStateClass.MaskState.values():
		var button = Button.new()
		button.text = GlobalStateClass.MaskState.keys()[state]
		button.pressed.connect(on_color_button_pressed.bind(state))
		container.add_child(button)

func on_color_button_pressed(state : GlobalStateClass.MaskState):
	camera.transition_to_preset(state)

	pass
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		visible = !visible

func _on_color_button_pressed() -> void:
	camera.transition_to_preset(GlobalStateClass.MaskState.Full)
func _on_grey_button_pressed() -> void:
	camera.transition_to_preset(GlobalStateClass.MaskState.Grey)
