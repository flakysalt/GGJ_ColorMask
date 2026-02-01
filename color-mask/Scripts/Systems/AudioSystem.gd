extends AudioStreamPlayer


func _ready() -> void:
	set_layer(false,1,0)
	set_layer(false,2,0)
	set_layer(false,3,0)
	set_layer(false,4,0)
	play()

func set_layer(enabled: bool, layer : int, duration : float = 10.0):
	
	var sync_stream = stream
	var current_vol = sync_stream.get_sync_stream_volume(layer)
	var volume = 0.0 if enabled else -80.0

	var tween = create_tween()
	tween.tween_method(
		func(vol): sync_stream.set_sync_stream_volume(layer, vol),
		current_vol,  # Start volume (silent)
		volume,    # End volume (full)
		duration
	)
	
