extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$marker.definedScale = Vector2.ONE * 0.02;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
