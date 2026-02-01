extends CharacterBody2D
class_name PlayerCharacter

@export var speed = 100
@export var step_length : int = 50
@export var use_smooth_movement :bool

var impulse_velocity : Vector2 = Vector2.ZERO

var state : State
var currentInteractable
var goal_movement_position : Vector2

enum State{
	Idle,
	Walking,
	SmoothMovement,
	Conversation
}

func _ready() -> void:
	add_to_group("player")
	if use_smooth_movement:
		state = State.SmoothMovement

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if state == State.Conversation:
		return
	handle_interact()
	var input_y = Input.get_axis("move_up","move_down")
	var input_x = Input.get_axis("move_left","move_right")
	
	var inputVector = Vector2(input_x,input_y)
	
	match state:
		State.Idle:
			if(inputVector != Vector2.ZERO):
				state = State.Walking
				goal_movement_position = global_position + inputVector * step_length
		State.Walking:
			handle_movement(delta)
		State.SmoothMovement:
			velocity = inputVector * speed + impulse_velocity
			impulse_velocity = impulse_velocity.lerp(Vector2.ZERO, 5 * delta)  # Decay over time
			update_animation(inputVector)
			move_and_slide()
	pass
	
func update_animation(direction: Vector2):
	var animated_sprite = $AnimatedSprite2D
	
	if(direction != Vector2.ZERO):
		animated_sprite.play()
		if abs(direction.y) > abs(direction.x):
			if direction.y > 0:
				animated_sprite.animation = "walk_down"
			else:
				animated_sprite.animation = "walk_up"
		else:
			if direction.x > 0:
				animated_sprite.animation = "walk_right"
			else:
				animated_sprite.animation = "walk_left"
				
	else:
		animated_sprite.stop()
		animated_sprite.frame = 1 
func handle_movement(delta):
	var direction : Vector2 = (goal_movement_position- global_position).normalized()
	velocity = direction * speed

	#translate(direction * delta * speed)
	move_and_slide()
	if global_position.distance_to(goal_movement_position) < 1:
		position = goal_movement_position
		state = State.Idle
	
	
func handle_interact():
	if currentInteractable != null && Input.is_action_just_pressed("interact"):
		currentInteractable.interact()

func interactwith(body: Node2D):
	print(body.name)
	if(body.has_method("interact")):
		currentInteractable = body

func _on_interact_area_area_entered(area: Area2D) -> void:
	interactwith(area)
func _on_interact_area_body_entered(body: Node2D) -> void:
	interactwith(body)
func _on_interact_area_body_exited(body: Node2D) -> void:
	if body == currentInteractable:
		currentInteractable = null
func _on_interact_area_area_exited(area: Area2D) -> void:
	if area == currentInteractable:
		currentInteractable = null
