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
			Audio.set_layer(true,1)
			pass
		3,4,5:
			Audio.set_layer(true,2)
			pass
		6,7:
			Audio.set_layer(true,3)
			pass
		8,9,10:
			Audio.set_layer(true,4)
			pass
		11,12:
			Audio.set_layer(true,5)
			pass

func addToState(id : String):
	state.append(id)

func hasState(id : String) -> bool:
	return state.has(id)
