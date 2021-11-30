extends Node

onready var Bug: KinematicBody2D = get_node("Bug")
onready var BugStartPosition: Position2D = get_node("BugStartPosition")
onready var Dice: Node2D = get_node("Dice")
onready var Traps: Array = get_tree().get_nodes_in_group("traps")
onready var Obstacles: Array = get_tree().get_nodes_in_group("obstacles")
onready var PlayerOne: Node = get_node("PlayerOne")
onready var PlayerTwo: Node = get_node("PlayerTwo")

#-------------------------------------------------------------------------------
# Parent methods
#-------------------------------------------------------------------------------

func _ready():
    _connect_signals()
    new_game()

#-------------------------------------------------------------------------------
# Instance methods
#-------------------------------------------------------------------------------

func _connect_signals():
    for obstacle in Obstacles:
        obstacle.connect("activated", self, "_on_Obstacle_activated")


func new_turn():
    var obstacle_group: String = "obstacles"

    for obstacle in Obstacles:
        obstacle.input_pickable = false

    Dice.roll()
    if Dice.current_face != "random":
        obstacle_group = "obstacles_%s" % Dice.current_face

    var selected_obstacles: Array = get_tree().get_nodes_in_group(obstacle_group)
    for obstacle in selected_obstacles:
        obstacle.input_pickable = true


func assign_trap(player: Node):
    var idx: int = randi() % Traps.size()
    var trap: Area2D = Traps[idx]
    Traps.remove(idx)
    trap.player = player
    print_debug('action="assign trap" source="%s" target="%s"' % [trap, player])


func new_game():
    assign_trap(PlayerOne)
    assign_trap(PlayerTwo)

    for trap_remains in Traps:
        trap_remains.queue_free()

    new_turn()

#-------------------------------------------------------------------------------
# Connected signals
#-------------------------------------------------------------------------------

func _on_Obstacle_activated():
    new_turn()


func _on_Bug_catched():
    Bug.position = BugStartPosition.position
    Bug.show()

    for obstacle in Obstacles:
        obstacle.restart()

    Bug.set_process(true)
