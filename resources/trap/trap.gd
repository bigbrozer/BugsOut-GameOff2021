extends Area2D

var player: Node

#-------------------------------------------------------------------------------
# Parent methods
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Instance methods
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Connected signals
#-------------------------------------------------------------------------------

func _on_Trap_body_entered(body):
    print_debug("action='bug entered trap' source='%s' name='%s'" % [self, body.name])
    body.catch(self)
