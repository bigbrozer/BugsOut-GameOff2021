extends Area2D

var player: Node

onready var Sprite: Sprite = get_node("Sprite")

#-------------------------------------------------------------------------------
# Parent methods
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Instance methods
#-------------------------------------------------------------------------------

# Returns the sprite picture associated to this trap
#
func get_image():
    return Sprite.texture

#-------------------------------------------------------------------------------
# Connected signals
#-------------------------------------------------------------------------------

func _on_Trap_body_entered(body):
    print_debug("action='bug entered trap' source='%s' name='%s'" % [self, body.name])
    body.catch(self)
