extends Area2D

onready var tween = get_node("Tween")

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
	var _new_angle = self.rotation + (PI / 2)
	print_debug("%s: new rotation angle is %f" % [self, _new_angle])
	
	tween.interpolate_property(self, "rotation",
							   self.rotation, _new_angle, 0.08,
							   Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()

#-------------------------------------------------------------------------------
# Connected signals
#-------------------------------------------------------------------------------

func _on_obstacle_wood_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		print_debug("Mouse click on %s" % self)
		rotate_clockwise()
