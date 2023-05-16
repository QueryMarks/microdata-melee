class_name Move

# Contains array of valid move input sequences, example: [["2", "3", "6", "a"], ["2", "3", "6", "b"]]
var move_input_sequences = []
# Number of frames allowed between inputs in sequence. Charge moves or moves with very unique inputs should inherit this class and alter its logic.
var lenience := 8
# State to change to on a valid input sequence.
var state : State


# Method to check if inputs match a move input sequence. Takes an array of inputs.
