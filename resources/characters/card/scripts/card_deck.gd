extends Node

var deck = []
var hand = []

@export var clubs_palette : Texture2D
@export var diamonds_palette : Texture2D
@export var hearts_palette : Texture2D
@export var spades_palette : Texture2D
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
func _process(_delta):
	pass

func new_hand():
	hand.clear()
	for count in range(5):
		hand.append(deck[count])
func which_suit(index):
	if "Clubs" in hand[index]:
		print("Clubs")
		return clubs_palette
	elif "Diamonds" in hand[index]:
		print("Diamonds")
		return diamonds_palette
	elif "Hearts" in hand[index]:
		print("Hearts")
		return hearts_palette
	elif "Spades" in hand[index]:
		print("SPADES REAL")
		return spades_palette
	else:
		print("fucked up if true")
		return null
