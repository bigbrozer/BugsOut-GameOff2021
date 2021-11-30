extends StaticBody2D

signal activated

var start_rotation: float

const ROTATE_STEP_ANGLE = PI / 2 # 90 deg

export(float) var rotate_speed = 0.2

onready var RotateTween = get_node("RotateTween")

#-------------------------------------------------------------------------------
# Parent methods
#-------------------------------------------------------------------------------

func _ready():
    input_pickable = true
    start_rotation = rotation

#-------------------------------------------------------------------------------
# Instance methods
#-------------------------------------------------------------------------------

func restart():
    rotate_clockwise(start_rotation, false)


# Rotate clockwise the obstacle
#
func rotate_clockwise(angle: float = ROTATE_STEP_ANGLE, is_relative: bool = true):
    var _angle: float

    if not RotateTween.is_active():
        if rotation >= TAU:
            rotation = 0

        if is_relative:
            _angle = rotation + angle
        else:
            _angle = angle

        print_debug(
            "action='update rotation angle' source='%s' value='%f'" % [self, _angle])
        RotateTween.interpolate_property(self, "rotation",
                                   rotation, _angle, rotate_speed,
                                   RotateTween.TRANS_BACK, RotateTween.EASE_OUT)
        RotateTween.start()

#-------------------------------------------------------------------------------
# Connected signals
#-------------------------------------------------------------------------------

func _on_Obstacle_input_event(_viewport, event, _shape_idx):
    if (event is InputEventMouseButton && event.pressed):
        print_debug("action='mouse click' source='%s' value='%s'" % [self, event])
        rotate_clockwise()
        emit_signal("activated")
