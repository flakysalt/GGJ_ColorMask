extends AudioStreamPlayer

func _ready() -> void:
	set_layer(false,1)
	set_layer(false,2)
	set_layer(false,3)
	set_layer(false,4)


func set_layer(enabled: bool, layer : int):
	var sync_stream = stream
	var volume = 0.0 if enabled else -80.0
	sync_stream.set_sync_stream_volume(layer,volume)
