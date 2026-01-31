extends Node
class_name GlobalStateClass

enum MaskState{
	Grey,
	Full,
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
	Twelve
}

var state: Array[String] = []

var currentMaskState : MaskState

func addToState(id : String):
	state.append(id)

func hasState(id : String) -> bool:
	return state.has(id)
