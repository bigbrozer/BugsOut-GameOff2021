extends KinematicBody2D

var velocity: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.RIGHT
var max_speed: int = 200
var jitter_force: int = 100

onready var MovementLine = Line2D.new()
onready var CollisionLine = Line2D.new()
onready var Heading = get_node("Heading")
onready var Sprite = get_node("Heading/Sprite")

#-------------------------------------------------------------------------------
# Parent methods
#-------------------------------------------------------------------------------

func _ready():
    add_child(MovementLine)
    add_child(CollisionLine)

    MovementLine.default_color = ColorN("red")
    MovementLine.width = 2
    CollisionLine.default_color = ColorN("green")
    CollisionLine.width = 2

func _physics_process(delta):
    update_debug_vectors()
    update_position(delta)

#-------------------------------------------------------------------------------
# Instance methods
#-------------------------------------------------------------------------------

func update_debug_vectors():
    MovementLine.clear_points()
    CollisionLine.clear_points()
    MovementLine.update()
    CollisionLine.update()

func update_position(delta):
    var jitter_angle: float = rand_range(-2, 2)
    var target: Vector2 = direction.normalized() * max_speed

    var collision: KinematicCollision2D = move_and_collide(velocity * delta)

    velocity = velocity.linear_interpolate(target, delta)
    velocity = velocity.clamped(max_speed)
    velocity = velocity.rotated(lerp_angle(0, deg2rad(jitter_angle * jitter_force), delta))
    rotation = velocity.angle()

    MovementLine.add_point(Vector2.ZERO)
    MovementLine.add_point(Vector2(velocity.length(), 0))

    if collision:
        var body: StaticBody2D = collision.get_collider()
        var part: CollisionShape2D = collision.local_shape
        var normal: Vector2 = collision.normal
        var remainder: Vector2 = collision.remainder
        var slide = velocity.slide(normal)

        if body.is_in_group("obstacles") and part.name == "HeadCollision":
            var reflect = remainder.bounce(normal)
            var new_direction: Vector2 = reflect.normalized()
            direction = new_direction

            CollisionLine.add_point(Vector2.ZERO)
            CollisionLine.add_point(direction * 100)

        # warning-ignore:return_value_discarded
        move_and_collide(slide * delta)

#-------------------------------------------------------------------------------
# Connected signals
#-------------------------------------------------------------------------------
