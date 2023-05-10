extends Node

var deck = []
var hand = []
var player


var card_hand_ui_scene = preload("res://resources/characters/card/card_hand_ui.tscn")
@export var clubs_palette : Texture2D
@export var diamonds_palette : Texture2D
@export var hearts_palette : Texture2D
@export var spades_palette : Texture2D
# Called when the node enters the scene tree for the first time.
func _ready():
	
	for suit_string in ["Clubs","Diamonds","Hearts","Spades"]:
		for rank_string in ["Ace","2","3","4","5","6","7","8","9","10","Jack","Queen","King"]:
			var suit = CardSuit.new(suit_string)
			var rank = CardRank.new(rank_string)
			var card = Card.new()
			card.suit = suit
			card.rank = rank
			deck.append(card)
			
	deck.shuffle()
	new_hand()
	var card_hand_ui = card_hand_ui_scene.instantiate()
	get_tree().get_root().get_node("RoundStart").camera.add_child(card_hand_ui)
	player = get_parent()
	if player.player_index == 1:
		card_hand_ui.position.x -= 58
		card_hand_ui.position.y += 15
	elif player.player_index == 2:
		card_hand_ui.position.x += 58
		card_hand_ui.position.y += 15
	var index = 0
	for card_ui in card_hand_ui.get_child(0).get_children():
		print(card_ui.get_path())
		card_ui.get_node("Sprite2D").material = card_ui.get_node("Sprite2D").material.duplicate()
		if player.player_index == 1:
			if RoundStartInfo.p1_palette != "":
				card_ui.get_node("Sprite2D").material.set_shader_parameter("palette",  load(RoundStartInfo.p1_palette))
		elif player.player_index == 2:
			if RoundStartInfo.p2_palette != "":
				card_ui.get_node("Sprite2D").material.set_shader_parameter("palette",  load(RoundStartInfo.p2_palette))
		card_ui.get_node("Label").text = hand[index].rank.rank_abbrev
		index += 1
		
	for card in hand:
		print(card.rank.rank_string + " of " + card.suit.suit_string)
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
