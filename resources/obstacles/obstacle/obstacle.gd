extends StaticBody2D

const ROTATE_STEP_ANGLE = PI / 2 # 90 deg

export(float) var rotate_speed = 0.2

onready var RotateTween = get_node("RotateTween")

#-------------------------------------------------------------------------------
# Parent methods
#-------------------------------------------------------------------------------

func _init():
    add_to_group("obstacles")

func _ready():
    input_pickable = true

#-------------------------------------------------------------------------------
# Instance methods
#-------------------------------------------------------------------------------

func rotate_clockwise():
    if not RotateTween.is_active():
        var _new_angle: float

        if rotation >= TAU:
            rotation = 0
        _new_angle = rotation + ROTATE_STEP_ANGLE
        print_debug(
            "action='update rotation angle' source='%s' value='%f'" % [self, _new_angle])
        RotateTween.interpolate_property(self, "rotation",
                                   rotation, _new_angle, rotate_speed,
                                   RotateTween.TRANS_BACK, RotateTween.EASE_OUT)
        RotateTween.start()

#-------------------------------------------------------------------------------
# Connected signals
#-------------------------------------------------------------------------------

func _on_Obstacle_input_event(_viewport, event, _shape_idx):
    if (event is InputEventMouseButton && event.pressed):
        print_debug("action='mouse click' source='%s' value='%s'" % [self, event])
        rotate_clockwise()
