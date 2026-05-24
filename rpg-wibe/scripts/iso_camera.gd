class_name IsoCamera
extends Camera3D

## Orthographic isometric camera fixed at -45 deg pitch and 45 deg yaw.
## Smoothly follows `target_path` with a constant world-space offset.

const PITCH_DEG := 45.0
const YAW_DEG := 45.0
const DISTANCE := 20.0

@export var target_path: NodePath
@export var view_size: float = 8.0
@export var follow_speed: float = 10.0

var target: Node3D
var _offset: Vector3 = Vector3.ZERO

func _ready() -> void:
	projection = PROJECTION_ORTHOGONAL
	size = view_size
	var pitch_rad := deg_to_rad(PITCH_DEG)
	var yaw_rad := deg_to_rad(YAW_DEG)
	_offset = Vector3(
		DISTANCE * cos(pitch_rad) * sin(yaw_rad),
		DISTANCE * sin(pitch_rad),
		DISTANCE * cos(pitch_rad) * cos(yaw_rad),
	)
	## Fixed rotation: pitch down, yaw to face the target diagonally.
	## Godot rotation order is YXZ, so yaw applies first then pitch in local frame.
	rotation = Vector3(-pitch_rad, yaw_rad, 0.0)

	if not target_path.is_empty():
		target = get_node_or_null(target_path) as Node3D
	if target == null:
		push_warning("IsoCamera: target_path did not resolve: %s" % target_path)
		global_position = _offset
	else:
		global_position = target.global_position + _offset

func _process(delta: float) -> void:
	if target == null:
		return
	var desired := target.global_position + _offset
	global_position = global_position.lerp(desired, follow_speed * delta)
