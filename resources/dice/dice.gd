extends Node2D

var dice_faces: Array = [
    "bramble",
    "rock",
    "wood",
    "random",
    "random",
    "random",
]

var current_face: String

#-------------------------------------------------------------------------------
# Parent methods
#-------------------------------------------------------------------------------

func _ready():
    randomize()

#-------------------------------------------------------------------------------
# Instance methods
#-------------------------------------------------------------------------------

func roll():
    var roll_result: int = randi() % 6
    current_face = dice_faces[roll_result]
    $Sprite.texture = load("res://resources/dice/dice_%s.png" % current_face)
