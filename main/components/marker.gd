extends Node3D

@export var _texture : Texture;
const EPSILON = 0.0001;
@onready var arrow = $Sprite2D;
var definedScale = Vector2.ONE;
var lastScreenState = null;

func _ready():
#	self.screen_entered.connect(_on_screen_entered);
#	self.screen_exited.connect(_on_screen_exited);
	return;

func _process(delta):
	if (self._texture != $Sprite2D.texture):
		$Sprite2D.texture = self._texture;
	
	arrow.scale = (self.definedScale);
	var viewport_center := get_viewport().get_visible_rect().size * 0.5;
	var cam_to_pos := get_viewport().get_camera_3d().to_local(global_transform.origin);
	var center_to_edge := Vector2(cam_to_pos.x, -cam_to_pos.y)
	var element := int(center_to_edge.abs().aspect() < viewport_center.aspect())
	center_to_edge *= viewport_center[element] / max(abs(center_to_edge[element]), EPSILON)
	arrow.position = viewport_center + center_to_edge #-center_to_edge.normalized() * px_offset
	arrow.rotation = center_to_edge.angle() + PI * 0.5 # PI to fix image initial rotation
	return;

func _physics_process(delta):
	# get current camera
	var camera = self.get_viewport().get_camera_3d();

	# intersect a ray between the camera and self
	
	# Returns the 2D coordinate in the Viewport rectangle that maps to the given 3D point in world space.
	# Note: When using this to position GUI elements over a 3D viewport, use is_position_behind() to prevent them from appearing if the 3D point is behind the camera:
	# This code block is part of a script that inherits from Node3D.
	# `control` is a reference to a node inheriting from Control.
#	control.visible = not get_viewport().get_camera_3d().is_position_behind(global_transform.origin)
	var viewportPos = get_viewport().get_camera_3d().unproject_position(global_transform.origin);
	var viewportRect = get_viewport().get_visible_rect();

	var newScreenState = viewportPos.y < viewportRect.size.y && viewportPos.y > viewportRect.position.y;
	# if we hit nothing - the flare is visible, so we show it
	if (self.lastScreenState != newScreenState):
		if newScreenState:
			print("screen entered")
			self._on_screen_entered();
		else: # othwerwise we hide it
			print("screen_exited");
			self._on_screen_exited();
		self.lastScreenState = newScreenState;
	return;

func _on_screen_entered():
	$Sprite2D.position = Vector2.ZERO;
	$Sprite2D.hide();
	self.set_process(false);
	pass # Replace with function body.


func _on_screen_exited():
	$Sprite2D.show();
	self.set_process(true);
	pass # Replace with function body.
