extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func show_text(text: String):
	$VBoxContainer/RichTextLabel.text= text
	$AnimationPlayer.play("DisplayText")
	pass
	
func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Left click!")


func show_placeholder():
	var test = "This is a long long test text.\n It even [b]supports [i]styling like this [/i] [/b]\n sounds crazy but works just like this"
	show_text(test)


func _on_button_pressed() -> void:
	show_placeholder()
	pass # Replace with function body.
