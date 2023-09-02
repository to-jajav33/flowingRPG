extends RigidBody3D

const SPEED = 10.0;
var dir = Vector3.ZERO;

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false);
	set_physics_process(true);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	dir.z = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"));
	dir.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"));
	
	var finalVel = dir * SPEED;
	self.apply_central_force((finalVel - self.linear_velocity) / delta);
	pass
