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
			var card = Card.new()
			card.suit = suit
			card.rank = rank
			deck.append(card)
			
	deck.shuffle()
	new_hand()
	for card in hand:
		print(card.rank + " of " + card.suit)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func new_hand():
	hand.clear()
	for count in range(5):
		hand.append(deck[count])
		
#no longer used, ignore the below function
func which_suit_palette(index):
	match hand[index].suit:
		"Clubs":
			return clubs_palette
		"Diamonds":
			return diamonds_palette
		"Hearts":
			return hearts_palette
		"Spades":
			return spades_palette
		_:
			return null
