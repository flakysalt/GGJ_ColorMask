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
	Seve,
	Eight,
	Nine,
	Ten,
	Eleven,
	Twelve,
	Full
}

var state: Array[String] = []

var currentMaskState : MaskState

func increase_color_mask():
	currentMaskState += 1
	match currentMaskState:
		1,2,3:
			Audio.set_layer(true,1)
			pass
		

func addToState(id : String):
	state.append(id)

func hasState(id : String) -> bool:
	return state.has(id)
