extends Area2D

func _ready():
	pass

func _process(_delta):
	pass

func _on_obstacle_wood_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		print_debug("Mouse click on %s" % self)
