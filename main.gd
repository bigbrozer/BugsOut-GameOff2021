extends Node

var current_player: Node

var game_over_scene: PackedScene = preload("res://game_over.tscn")

onready var Bug: KinematicBody2D = get_node("Bug")
onready var BugStartPosition: Position2D = get_node("BugStartPosition")
onready var Dice: Node2D = get_node("Dice")
onready var Traps: Array = get_node("Traps").get_children()
onready var Doors: Array = get_node("Doors").get_children()
onready var Obstacles: Array = get_node("Obstacles").get_children()
onready var Players: Array = get_node("Players").get_children()
onready var PlayerOne: Node = get_node("Players/PlayerOne")
onready var PlayerTwo: Node = get_node("Players/PlayerTwo")
onready var CurrentPlayer: Node2D = get_node("CurrentPlayer")

#-------------------------------------------------------------------------------
# Parent methods
#-------------------------------------------------------------------------------

func _ready():
    _connect_signals()
    random_player()
    next_player()
    new_game()

#-------------------------------------------------------------------------------
# Instance methods
#-------------------------------------------------------------------------------

func _connect_signals():
    for obstacle in Obstacles:
        obstacle.connect("activated", self, "_on_Obstacle_activated")


func random_player():
    var idx: int = randi() % Players.size()
    current_player = Players[idx]
    print_debug('action="first player" target="%s"' % current_player)


func next_player():
    var idx: int = current_player.get_index() - 1
    idx += 1 % Players.size() - 1
    current_player = Players[idx]
    CurrentPlayer.set_name(current_player.get_node("Label").text)
    print_debug('action="next player" target="%s"' % current_player)


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

    next_player()


func assign_trap(player: Node):
    var idx: int = randi() % Traps.size()
    var trap: Area2D = Traps[idx]
    var door: StaticBody2D = Doors[idx]
    Traps.remove(idx)
    Doors.remove(idx)
    player.get_node("Coin").set_trap_image(trap)
    trap.player = player
    door.queue_free()
    print_debug('action="assign trap" source="%s" target="%s" door="%s"' % [trap, player, door])


func remove_remaining_traps():
    for trap_remains in Traps:
        trap_remains.queue_free()


func new_game():
    assign_trap(PlayerOne)
    assign_trap(PlayerTwo)
    remove_remaining_traps()
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


func _on_Coin_target_reached(source: Node2D):
    var player_win: Node = source.get_parent()
    print_debug('action="player win" source="%s"' % source.get_parent())
    Globals.winner_name = player_win.get_node("Label").text
    get_tree().change_scene_to(game_over_scene)
