extends Node

var deck = []
var hand = []
# Called when the node enters the scene tree for the first time.
func _ready():
	
	for suit in ["Clubs","Diamonds","Hearts","Spades"]:
		for rank in ["Ace","2","3","4","5","6","7","8","9","10","Jack","Queen","King"]:
			var string = rank + " of " + suit
			deck.append(string)
	deck.shuffle()
	new_hand()
	print(hand)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func new_hand():
	hand.clear()
	for count in range(5):
		hand.append(deck[count])
