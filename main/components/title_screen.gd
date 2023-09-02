extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false);
	set_process_input(true);
	pass # Replace with function body.

func _input(event):
	if (not (event is InputEventMouse)):
		self.visible = false;
		Common.emit_signal("signal_start_gameplay");
		set_process_input(false);
		return;
	pass;
