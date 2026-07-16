extends Resource
class_name CardData

# Entirely  unique identifiers to support multiple of one
# card, as well as who owns what card
@export var id: int # each instance has its own
@export var cardID: int # used for global card indexing

# Card stats unique to the card type
@export var artWork: Texture2D
@export var name: String
@export var description: String
@export var healthStat: String
@export var attackStat: String
