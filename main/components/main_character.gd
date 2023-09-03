extends RigidBody3D

const SPEED = 10.0;
var dir = Vector3.ZERO;

func _init():
	self.add_to_group("group_main_character");
	return;

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false);
	set_physics_process(true);
	Common.beginGamePlay();
	Common.signal_start_gameplay.connect(_on_signal_start_gameplay);
	pass # Replace with function body.

func _on_signal_start_gameplay():
	$Camera3D/timer_light.startMorning();
	return;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	dir.z = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"));
	dir.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"));
	
	var finalVel = dir * SPEED;
	self.apply_central_force((finalVel - self.linear_velocity) / delta);
	pass
