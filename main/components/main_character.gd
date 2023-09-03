extends RigidBody3D

const SPEED = 10.0;
var dir = Vector3.ZERO;
var nearbyResources = [];

func _init():
	self.add_to_group("group_main_character");
	return;

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false);
	set_physics_process(true);
	set_process_input(true);
	
	Common.beginGamePlay();
	Common.signal_start_gameplay.connect(_on_signal_start_gameplay);
	pass # Replace with function body.

func _input(event):
	if (Input.is_action_just_pressed("ui_select")):
		if (!nearbyResources.is_empty()):
			var res = nearbyResources[0];
			res.startCollectingResource(self);
		return;
	return;

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


func _on_area_3d_body_entered(body):
	if (body.has_method("startCollectingResource")):
		if (!nearbyResources.has(body)):
			nearbyResources.push_back(body);
	
	if (body.has_method("highlightSelectable")):
		body.highlightSelectable();
	pass # Replace with function body.


func _on_area_3d_body_exited(body):
	if (nearbyResources.has(body)):
		nearbyResources.erase(body);
		
	if (body.has_method("unhighlightSelectable")):
		body.unhighlightSelectable();
	pass # Replace with function body.
