extends KinematicBody2D

var velocity: Vector2
var aim: Vector2 = Vector2.RIGHT

var max_speed: int = 100
var max_steering: float = 2.5

#-------------------------------------------------------------------------------
# Parent methods
#-------------------------------------------------------------------------------

func _physics_process(delta):
    var steering: Vector2 = Vector2.ZERO

    steering += seek_steering()
    steering = steering.clamped(max_steering)

    velocity += steering
    velocity = velocity.clamped(max_speed)
    velocity = velocity.rotated(rand_range(-0.1, 0.1))

    rotation = velocity.angle()

    var collision = move_and_collide(velocity * delta)
    if collision:
        var normal: Vector2 = collision.normal
        var part: CollisionShape2D = collision.local_shape
        steering = steering.slide(normal)

        if part.name == "HeadCollision":
            aim = steering.bounce(normal)

        move_and_collide(steering * delta)

#-------------------------------------------------------------------------------
# Instance methods
#-------------------------------------------------------------------------------

func seek_steering() -> Vector2:
    var desired_velocity: Vector2 = aim.normalized() * max_speed
    return desired_velocity - velocity

#-------------------------------------------------------------------------------
# Connected signals
#-------------------------------------------------------------------------------
