extends Control

onready var Winner: Label = get_node("VBoxContainer/CenterContainer2/WinnerName")

#-------------------------------------------------------------------------------
# Parent methods
#-------------------------------------------------------------------------------

func _ready():
    Winner.text = Globals.winner_name

#-------------------------------------------------------------------------------
# Connected signals
#-------------------------------------------------------------------------------

func _on_RetryButton_pressed():
    get_tree().change_scene("res://main.tscn")
