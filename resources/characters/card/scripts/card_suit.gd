class_name CardSuit

var damage_type
var palette : Texture2D
var suit_string : String
var suit_icon : Texture2D
var palettes = []

func _init(s):
	suit_string = s
	match suit_string:
		"Spades":
			palette = preload("res://resources/characters/card/palettes/suits/card_suit_spades.png")
		"Hearts":
			palette = preload("res://resources/characters/card/palettes/suits/card_suit_hearts.png")
		"Diamonds":
			palette = preload("res://resources/characters/card/palettes/suits/card_suit_diamonds.png")
		"Clubs":
			palette = preload("res://resources/characters/card/palettes/suits/card_suit_clubs.png")
