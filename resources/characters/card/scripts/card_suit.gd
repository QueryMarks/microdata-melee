class_name CardSuit

var damage_type
var palette : Texture2D
var suit_string : String
var suit_icon_index : int
var palettes = []

func _init(s):
	suit_string = s
	match suit_string:
		"Spades":
			palette = preload("res://resources/characters/card/palettes/suits/card_suit_spades.png")
			suit_icon_index = 1
		"Hearts":
			palette = preload("res://resources/characters/card/palettes/suits/card_suit_hearts.png")
			suit_icon_index = 2
		"Diamonds":
			palette = preload("res://resources/characters/card/palettes/suits/card_suit_diamonds.png")
			suit_icon_index = 3
		"Clubs":
			palette = preload("res://resources/characters/card/palettes/suits/card_suit_clubs.png")
			suit_icon_index = 4
	
