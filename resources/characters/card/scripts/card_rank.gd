class_name CardRank

var summon : Resource #file path for summon
var rank_string : String
var rank_abbrev : String

func _init(r):
	rank_string = r
	match rank_string:
		"Ace":
			rank_abbrev = "A"
		"10":
			rank_abbrev = "0"
		"Jack":
			rank_abbrev = "J"
		"King":
			rank_abbrev = "K"
		"Queen":
			rank_abbrev = "Q"
		_:
			rank_abbrev = rank_string
	if ResourceLoader.exists("res://resources/characters/card/summon_" + rank_abbrev.to_lower() + ".tscn"):
		summon = load("res://resources/characters/card/summon_" + rank_abbrev.to_lower() + ".tscn")
	else:
		summon = load("res://resources/characters/card/summon_2.tscn")
