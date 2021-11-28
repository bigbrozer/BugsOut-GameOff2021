extends Node

onready var Dice: Node2D = get_node("Dice")
onready var obstacles: Array = get_tree().get_nodes_in_group("obstacles")

#-------------------------------------------------------------------------------
# Parent methods
#-------------------------------------------------------------------------------

func _ready():
    _connect_signals()
    start_game()

#-------------------------------------------------------------------------------
# Instance methods
#-------------------------------------------------------------------------------

func _connect_signals():
    for obstacle in obstacles:
        obstacle.connect("activated", self, "_on_Obstacle_activated")

func new_turn():
    var obstacle_group: String = "obstacles"

    for obstacle in obstacles:
        obstacle.input_pickable = false

    Dice.roll()
    if Dice.current_face != "random":
        obstacle_group = "obstacles_%s" % Dice.current_face

    var selected_obstacles: Array = get_tree().get_nodes_in_group(obstacle_group)
    for obstacle in selected_obstacles:
        obstacle.input_pickable = true

func start_game():
    new_turn()

#-------------------------------------------------------------------------------
# Connected signals
#-------------------------------------------------------------------------------

func _on_Obstacle_activated():
    new_turn()
