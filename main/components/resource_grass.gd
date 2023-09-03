extends RigidBody3D


func highlightSelectable():
	print("highlight grass");
	$MeshInstance3D.mesh.material.next_pass.cull_mode = BaseMaterial3D.CULL_BACK;
	$MeshInstance3D.mesh.material.next_pass.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED;
	$MeshInstance3D.mesh.material.next_pass.grow = true;
	$MeshInstance3D.mesh.material.next_pass.grow_amount = 0.05;
	return;

func unhighlightSelectable():
	print("UNHIGHLIGHT grass");
	$MeshInstance3D.mesh.material.next_pass.cull_mode = BaseMaterial3D.CULL_FRONT;
	$MeshInstance3D.mesh.material.next_pass.grow = false;
	return;
