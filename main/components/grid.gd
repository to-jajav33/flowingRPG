extends GridMap

const TILE_NAMES = {
	"tile_grass": "tile_grass",
	"tile_water": "tile_water",
}

var noiseGrid_floor = FastNoiseLite.new();
var noiseGrid_resource = FastNoiseLite.new();
@export_node_path("Node3D") var objToFollowPath;
var printOnce = true;
var startMapPos = null;

var chunkMapWidth = 32;
var chunkMapHeight = 32;

var resourceTracker = {};

# Called when the node enters the scene tree for the first time.
func _ready():
	noiseGrid_floor.seed = randi();
	noiseGrid_resource.seed = randi();
	
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
	var mapPos = self.local_to_map(self.to_local(globalPos));
	
	var halfW = ceil(chunkMapWidth * 0.5);
	var halfH = ceil(chunkMapHeight * 0.5);
	
	for x in range(-halfW, halfW):
		for z in range(-halfH, halfH):
			var currMapPos = mapPos + Vector3i(x, -1, z);
			
			var floorTileName = self.addFloor(currMapPos);
			self.addResource(currMapPos, floorTileName);
			continue;
		continue;
	self.printOnce = false;
	return;

func addFloor(currMapPos: Vector3i):
	var tileGroundVal = noiseGrid_floor.get_noise_3dv(currMapPos);
#	if (self.printOnce):
#		print("****floor tiles****");
#		print(tileGroundVal);
	var tileName = TILE_NAMES.tile_grass;
	currMapPos.y = -1;
	
	var halfW = ceil(chunkMapWidth * 0.5);
	var halfH = ceil(chunkMapHeight * 0.5);
	var startBufferW = halfW * 0.5;
	var startBufferH = halfH * 0.5;
	if ((currMapPos.x < startBufferW and currMapPos.x > -startBufferW) and (currMapPos.z < startBufferH and currMapPos.z > -startBufferH)):
		tileName = TILE_NAMES.tile_grass;
		currMapPos.y = -1;
	elif (tileGroundVal < 0.10):
		tileName = TILE_NAMES.tile_water;
		currMapPos.y = -2;
	self.set_cell_item(currMapPos, self.mesh_library.find_item_by_name(tileName));
	return tileName;

func addResource(currMapPos: Vector3i, floorTileName: String):
	var mapKey = str(currMapPos.x)+ '_' +str(currMapPos.z);
	if (resourceTracker.has(mapKey)):
		return;
	
	if (floorTileName != TILE_NAMES.tile_grass):
		return;
	
	var tileResourceVal = noiseGrid_resource.get_noise_3dv(currMapPos);
#	if (self.printOnce):
#		print("****resource tiles****");
#		print(tileResourceVal);
	
	if (tileResourceVal < -0.4):
		resourceTracker[mapKey] = true;
		var resourceGrass: RigidBody3D = load("res://main/components/resource_grass.tscn").instantiate();
		for mainChar in self.get_tree().get_nodes_in_group("group_main_character"):
			resourceGrass.add_collision_exception_with(mainChar);
		self.add_child(resourceGrass);
		resourceGrass.global_position = self.to_global(self.map_to_local(currMapPos + Vector3i.UP));
	return;
