extends KinematicBody2D

var rotation_dir: int = 0
var velocity: Vector2

export(int) var speed = 200
export(float) var rotation_speed = 1.5

#-------------------------------------------------------------------------------
# Parent methods
#-------------------------------------------------------------------------------

func _ready():
    pass

func _physics_process(delta):
    get_input()
    velocity = move_and_slide(velocity)

#-------------------------------------------------------------------------------
# Instance methods
#-------------------------------------------------------------------------------

func get_input():
    look_at(get_global_mouse_position())
    velocity = Vector2()
    velocity = Vector2(speed, 0).rotated(rotation)

#-------------------------------------------------------------------------------
# Connected signals
#-------------------------------------------------------------------------------
