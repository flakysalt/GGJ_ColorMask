extends Node
class_name GlobalStateClass

enum MaskState{
	Grey,
	One,
	Two,
	Three,
	Four,
	Five,
	Six,
	Seven,
	Eight,
	Nine,
	Ten,
	Eleven,
	Full
}

var state: Array[String] = []

var currentMaskState : MaskState

func set_mask_state(state : MaskState):
	currentMaskState = state
	match currentMaskState:
		0,1,2:
			Audio.set_layer(true,0)
			Audio.set_layer(false,1)
			Audio.set_layer(false,2)
			Audio.set_layer(false,3)
			Audio.set_layer(false,4)
			pass
		3,4,5:
			Audio.set_layer(true,0)
			Audio.set_layer(true,1)
			Audio.set_layer(false,2)
			Audio.set_layer(false,3)
			Audio.set_layer(false,4)
		6,7:
			Audio.set_layer(true,0)
			Audio.set_layer(true,1)
			Audio.set_layer(true,2)
			Audio.set_layer(false,3)
			Audio.set_layer(false,4)
		8,9,10:
			Audio.set_layer(true,0)
			Audio.set_layer(true,1)
			Audio.set_layer(true,2)
			Audio.set_layer(true,3)
			Audio.set_layer(false,4)
		11,12:
			Audio.set_layer(true,0)
			Audio.set_layer(true,1)
			Audio.set_layer(true,2)
			Audio.set_layer(true,3)
			Audio.set_layer(true,4)

func addToState(id : String):
	state.append(id)

func hasState(id : String) -> bool:
	return state.has(id)
