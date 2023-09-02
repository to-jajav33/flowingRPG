extends Node3D

var moisture = FastNoiseLite.new();


func startMorning():
	$AnimationPlayer.play("anim_daylight");
	return;
