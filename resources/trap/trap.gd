extends Area2D

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
    body.emit_signal("catched")
