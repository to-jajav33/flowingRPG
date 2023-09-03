extends RigidBody3D

var isBeingCollected = false;

func highlightCurrentSelected():
	print("highlight grass");
	$MeshInstance3D.mesh.material.next_pass.cull_mode = BaseMaterial3D.CULL_BACK;
	$MeshInstance3D.mesh.material.next_pass.albedo_color = Color.DARK_KHAKI;
	$MeshInstance3D.mesh.material.next_pass.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED;
	$MeshInstance3D.mesh.material.next_pass.grow = true;
	$MeshInstance3D.mesh.material.next_pass.grow_amount = 0.05;
	return;

func highlightSelectable():
	print("highlight grass");
	$MeshInstance3D.mesh.material.next_pass.cull_mode = BaseMaterial3D.CULL_BACK;
	$MeshInstance3D.mesh.material.next_pass.albedo_color = Color.WHITE;
	$MeshInstance3D.mesh.material.next_pass.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED;
	$MeshInstance3D.mesh.material.next_pass.grow = true;
	$MeshInstance3D.mesh.material.next_pass.grow_amount = 0.05;
	return;

func unhighlightSelectable():
	if (self.isBeingCollected):
		self.stopCollectingResource();
	
	print("UNHIGHLIGHT grass");
	$MeshInstance3D.mesh.material.next_pass.cull_mode = BaseMaterial3D.CULL_FRONT;
	$MeshInstance3D.mesh.material.next_pass.grow = false;
	return;

func startCollectingResource(fromObj):
	if (self.isBeingCollected):
		print('already being collected');
		return;
	
	print("start collecting resource");
	self.highlightCurrentSelected();
	self.isBeingCollected = true;
	return;

func stopCollectingResource():
	print("stop collecting resource");
	self.isBeingCollected = false;
	return;
