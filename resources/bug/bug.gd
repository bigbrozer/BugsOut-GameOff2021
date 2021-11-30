extends KinematicBody2D

signal catched

var velocity: Vector2
var aim: Vector2 = Vector2.UP
var max_speed: int = 100
var max_steering: float = 2.5

onready var AnimatedSprite: AnimatedSprite = get_node("AnimatedSprite")

#-------------------------------------------------------------------------------
# Parent methods
#-------------------------------------------------------------------------------

func _physics_process(delta):
    AnimatedSprite.play()
    _move(delta)

#-------------------------------------------------------------------------------
# Instance methods
#-------------------------------------------------------------------------------

# Update the bug position.
#
# Parameters:
#
# * `delta`: the delta value from `*_process` methods.
#
func _move(delta):
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
            if randi() % 10 <= 4:
                aim = steering.bounce(normal)
            else:
                aim = steering.bounce(-normal)

        # warning-ignore:return_value_discarded
        move_and_slide(steering * delta)


# Calculate the steering vector.
#
func seek_steering() -> Vector2:
    var desired_velocity: Vector2 = aim.normalized() * max_speed
    return desired_velocity - velocity


# Bug is catched
#
func catch(trap: Area2D):
    print_debug('action="bug catched" player="%s" source="%s"' % [trap.player, trap])
    hide()
    set_process(false)
    trap.player.get_node("Coin").increment_score()
    emit_signal("catched")
