extends Area2D
@export var id_to_deactivate : String
@export var push_speed : float = 300.0

func _on_body_entered(body: Node2D) -> void:
	if GlobalState.hasState(id_to_deactivate):
		return
		
	print("push")
	var player : CharacterBody2D = body
	print(body.name)

	var push_direction = (player.global_position - global_position).normalized()
	player.impulse_velocity = push_direction * push_speed
