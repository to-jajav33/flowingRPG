extends Node

signal signal_start_gameplay();

func beginGamePlay():
	self.emit_signal("signal_start_gameplay");
	return;
