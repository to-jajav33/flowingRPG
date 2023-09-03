extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$marker.definedScale = Vector2.ONE * 0.02;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func highlightSelectable():
	$MeshInstance3D.mesh.material.next_pass.cull_mode = BaseMaterial3D.CULL_FRONT;
	$MeshInstance3D.mesh.material.next_pass.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED;
	$MeshInstance3D.mesh.material.next_pass.grow = true;
	$MeshInstance3D.mesh.material.next_pass.grow_amount = 0.2;
	
	$MeshInstance3D2.mesh.material.next_pass.cull_mode = BaseMaterial3D.CULL_FRONT;
	$MeshInstance3D2.mesh.material.next_pass.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED;
	$MeshInstance3D2.mesh.material.next_pass.grow = true;
	$MeshInstance3D2.mesh.material.next_pass.grow_amount = 0.2;
	return;

func unhighlightSelectable():
	$MeshInstance3D.mesh.material.next_pass.grow = false;
	$MeshInstance3D2.mesh.material.next_pass.grow = false;
	return;
