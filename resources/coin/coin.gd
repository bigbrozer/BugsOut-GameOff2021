extends Node2D

var current_score: int = 0

onready var ScoreLabel: Label = get_node("ScoreLabel")
onready var AnimationTimer: Timer = get_node("AnimationTimer")
onready var AnimatedSprite: AnimatedSprite = get_node("AnimatedSprite")

#-------------------------------------------------------------------------------
# Parent methods
#-------------------------------------------------------------------------------

func _ready():
    AnimationTimer.start()

#-------------------------------------------------------------------------------
# Instance methods
#-------------------------------------------------------------------------------

func increment_score():
    current_score += 1
    ScoreLabel.text = str(current_score)

#-------------------------------------------------------------------------------
# Connected signals
#-------------------------------------------------------------------------------

func _on_AnimationTimer_timeout():
    var new_time: int = randi() % 5
    AnimationTimer.start(new_time)
    AnimatedSprite.play()


func _on_AnimatedSprite_animation_finished():
    AnimatedSprite.stop()
