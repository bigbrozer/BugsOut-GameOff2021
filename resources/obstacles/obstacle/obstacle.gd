extends Area2D

const ROTATE_STEP_ANGLE = PI / 2 # 90 deg

export(float) var rotate_speed = 0.2

#-------------------------------------------------------------------------------
# Parent methods
#-------------------------------------------------------------------------------

func _ready():
    rotation = 0.0

func _process(_delta):
    pass

#-------------------------------------------------------------------------------
# Instance methods
#-------------------------------------------------------------------------------

func rotate_clockwise():
    var _new_angle: float

    if not $Tween.is_active():
        if self.rotation >= TAU:
            self.rotation = 0
        _new_angle = self.rotation + ROTATE_STEP_ANGLE
        print_debug(
            "action='update rotation angle' source='%s' value='%f'" % [self, _new_angle])
        $Tween.interpolate_property(self, "rotation",
                                   self.rotation, _new_angle, rotate_speed,
                                   Tween.TRANS_BACK, Tween.EASE_OUT)
        $Tween.start()

#-------------------------------------------------------------------------------
# Connected signals
#-------------------------------------------------------------------------------

func _on_Obstacle_input_event(_viewport, event, _shape_idx):
    if (event is InputEventMouseButton && event.pressed):
        print_debug("action='mouse click' source='%s' value='%s'" % [self, event])
        rotate_clockwise()
