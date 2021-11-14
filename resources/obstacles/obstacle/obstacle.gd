extends Area2D

onready var tween = get_node("Tween")
const rotate_step_angle = PI / 2 # 90 deg
const rotate_speed = 1.0

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
    var _new_angle = 0

    if not tween.is_active():
        if self.rotation >= TAU:
            self.rotation = 0
        _new_angle = self.rotation + rotate_step_angle
        print_debug("action='show current rotation angle' source='%s' value='%f'" % [self, self.rotation])
        print_debug("action='update rotation angle' source='%s' value='%f'" % [self, _new_angle])
        tween.interpolate_property(self, "rotation",
                                   self.rotation, _new_angle, rotate_speed,
                                   Tween.TRANS_LINEAR, Tween.EASE_OUT)
        tween.start()

#-------------------------------------------------------------------------------
# Connected signals
#-------------------------------------------------------------------------------

func _on_obstacle_wood_input_event(_viewport, event, _shape_idx):
    if (event is InputEventMouseButton && event.pressed):
        print_debug("action='mouse click' source='%s' value='%s'" % [self, event])
        rotate_clockwise()
