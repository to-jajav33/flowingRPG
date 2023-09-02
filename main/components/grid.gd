extends GridMap

var noiseGrid = FastNoiseLite.new();
@export_node_path("Node3D") var objToFollowPath;
var printOnce = true;
var startMapPos = null;

# Called when the node enters the scene tree for the first time.
func _ready():
	noiseGrid.seed = randi();
	
	set_process(false);
	set_physics_process(true);
	pass # Replace with function body.

func _physics_process(delta):
	if (self.objToFollowPath):
		var objToFollow: Node3D = self.get_node(self.objToFollowPath);
		if (objToFollow):
			self.generateChunk(objToFollow.global_position);
	return;

func generateChunk(globalPos: Vector3):
	var chunkMapWidth = 32;
	var chunkMapHeight = 32;
	
	var mapPos = self.local_to_map(self.to_local(globalPos));
	
	var halfW = ceil(chunkMapWidth * 0.5);
	var halfH = ceil(chunkMapHeight * 0.5);
	
	for x in range(-halfW, halfW):
		for z in range(-halfH, halfH):
			var currMapPos = mapPos + Vector3i(x, -1, z);
			var tileGroundVal = noiseGrid.get_noise_3dv(currMapPos);
			if (printOnce):
				print(tileGroundVal);
				
			var tileName = "tile_grass";
			currMapPos.y = -1;
			
			var startBufferW = halfW * 0.5;
			var startBufferH = halfH * 0.5;
			if ((currMapPos.x < startBufferW and currMapPos.x > -startBufferW) and (currMapPos.z < startBufferH and currMapPos.z > -startBufferH)):
				tileName = "tile_grass";
				currMapPos.y = -1;
			elif (tileGroundVal < 0.10):
				tileName = "tile_water";
				currMapPos.y = -2;
			self.set_cell_item(currMapPos, self.mesh_library.find_item_by_name(tileName))
			continue;
		continue;
	self.printOnce = false;
	return;
