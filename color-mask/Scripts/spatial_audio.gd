extends Area2D

@onready var audio_player = $AudioStreamPlayer2D
@export var max_volume_db = 0.0
@export var min_volume_db = -80.0
@export var fade_speed = 2.0

var player_in_area = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	audio_player.volume_db = min_volume_db
	audio_player.play()

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_area = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_area = false

func _process(delta):
	print(audio_player.volume_db)
	if player_in_area:
		audio_player.volume_db = move_toward(audio_player.volume_db, max_volume_db, fade_speed * delta)
	else:
		audio_player.volume_db = move_toward(audio_player.volume_db, min_volume_db, fade_speed * delta)
