extends KinematicBody2D

var shaking_amount: float = 0.8
var shaking_angle: float = 0.1
var velocity: Vector2

export(int) var speed = 200

#-------------------------------------------------------------------------------
# Parent methods
#-------------------------------------------------------------------------------

func _physics_process(delta):
    update_position(delta)

#-------------------------------------------------------------------------------
# Instance methods
#-------------------------------------------------------------------------------

func update_position(delta):
    var rotation_jittery: float = shaking_angle * shaking_amount * rand_range(-1, 1)
    velocity = Vector2(speed, 0).rotated(rotation)
    rotation = rotation + rotation_jittery

    var collision = move_and_collide(velocity * delta)
    if collision:
        var body = collision.get_collider()
        if body.is_in_group("obstacles"):
            velocity = velocity.slide(collision.normal)

#-------------------------------------------------------------------------------
# Connected signals
#-------------------------------------------------------------------------------
