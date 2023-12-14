extends Node

var deck = []
var hand = [null, null, null, null, null]
var player
var card_hand_ui


var card_hand_ui_scene = preload("res://resources/characters/card/card_hand_ui.tscn")
@export var clubs_palette : Texture2D
@export var diamonds_palette : Texture2D
@export var hearts_palette : Texture2D
@export var spades_palette : Texture2D

var player_palette : Texture2D
@export var used_card_palette : Texture2D
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
	card_hand_ui = card_hand_ui_scene.instantiate()
	get_tree().get_root().get_node("RoundStart").camera.add_child(card_hand_ui)
	player = get_parent()
	if player.player_index == 1:
		card_hand_ui.position.x -= 58
		card_hand_ui.position.y += 15
	elif player.player_index == 2:
		card_hand_ui.position.x += 58
		card_hand_ui.position.y += 15

	
	if player.player_index == 1:
		if RoundStartInfo.p1_palette != "":
			player_palette = load(RoundStartInfo.p1_palette)
	elif player.player_index == 2:
		if RoundStartInfo.p2_palette != "":
			player_palette = load(RoundStartInfo.p2_palette)
	
	var index = 0
	for card_ui in card_hand_ui.get_child(0).get_children():
		print(card_ui.get_path())
		card_ui.get_node("Sprite2D").material = card_ui.get_node("Sprite2D").material.duplicate()
		index += 1
	update_hand()
		
	for card in hand:
		print(card.rank.rank_string + " of " + card.suit.suit_string)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func update_hand():
	var index = 0
	for card_ui in card_hand_ui.get_child(0).get_children():
		if hand[index] != null:
			print(hand[index].rank.rank_abbrev)
			card_ui.get_node("Label").text = hand[index].rank.rank_abbrev
			card_ui.get_node("Sprite2D").material.set_shader_parameter("palette",  player_palette)
			card_ui.get_node("SuitSprite").frame = hand[index].suit.suit_icon_index
				
		else: 
			print("no card here")
			card_ui.get_node("Label").text = ""
			card_ui.get_node("Sprite2D").material.set_shader_parameter("palette",  used_card_palette)
			card_ui.get_node("SuitSprite").frame = 0
		index += 1

func _process(_delta):
	pass

func new_hand():
	for i in hand.size():
		if hand[i] != null:
			card_used(i)
	for count in range(5):
		hand[count] = (deck[count])
		print(deck[count].rank.rank_string+" "+deck[count].suit.suit_string)
	for count in range(5):
		deck.remove_at(count)
	
func card_used(index):
	deck.append(hand[index])
	hand[index] = null
	update_hand()
	
func refill_hand():
	var deck_index = 0
	for i in hand.size():
		if hand[i] == null:
			print("null!")
			hand[i] = deck[deck_index]
			
			deck_index += 1
	for count in range(deck_index+1):
		deck.remove_at(count)
	update_hand()
	
func shuffle_hand():
	new_hand()
	update_hand()

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
