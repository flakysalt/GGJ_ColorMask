extends Node2D
@export var scene_to_transition_to: String

func _on_area_2d_body_entered(body: Node2D) -> void:
	if scene_to_transition_to == null:
		printerr("Missing Packed Scene")
		return
	
	# Add a small delay before transitioning
	get_tree().change_scene_to_file(scene_to_transition_to)
