class_name Player
extends CharacterBody3D

## Player controller for the walk prototype.
## - WASD / arrows -> screen-aligned movement (rotated by camera yaw)
## - State: idle when velocity is zero, walk otherwise
## - Sprite direction resolved from velocity angle into one of 8 named directions
## - SpriteFrames built at runtime from the on-disk pixellab output

const SPEED := 4.0
const ASSETS_ROOT := "res://assets/characters/test-female-placeholder"
## Compass directions ordered by angle bin from `atan2(z, x)`, where 0 = east.
const DIRS := ["east", "south-east", "south", "south-west", "west", "north-west", "north", "north-east"]
const WALK_FRAMES := 8
## Camera yaw used to align WASD input with what the player sees on screen.
const CAMERA_YAW_DEG := 45.0

@export var idle_speed: float = 4.0
@export var walk_speed: float = 10.0

@onready var sprite: AnimatedSprite3D = $AnimatedSprite3D

var _last_dir: String = "south"
var _input_rotation: float = deg_to_rad(CAMERA_YAW_DEG)

func _ready() -> void:
	sprite.sprite_frames = _build_sprite_frames()
	sprite.play("idle_south")

func _process(delta: float) -> void:
	var input_vec := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var raw := Vector3(input_vec.x, 0.0, input_vec.y)
	## Rotate input around Y by the camera yaw so screen-up always means
	## "into the camera" regardless of the camera angle.
	var move_dir := raw.rotated(Vector3.UP, _input_rotation)
	if move_dir.length() > 1.0:
		move_dir = move_dir.normalized()
	velocity = move_dir * SPEED
	move_and_slide()

	var moving := move_dir.length() > 0.01
	if moving:
		## Animation direction is taken from the raw screen-relative input,
		## so "south" sprite plays when the player presses down on screen
		## regardless of how the world is oriented under the iso camera.
		_last_dir = _dir_from_input(input_vec)
	var target_anim := ("walk_" if moving else "idle_") + _last_dir
	if sprite.animation != target_anim:
		sprite.play(target_anim)

## Map a screen-space 2D input vector to one of 8 named compass directions.
## Convention: input.x +1 = right on screen ("east"), input.y +1 = down on screen ("south").
func _dir_from_input(v: Vector2) -> String:
	var angle := atan2(v.y, v.x)  ## -PI..PI, 0 = east, +PI/2 = south
	var bin := int(round(angle / (PI / 4.0)))
	bin = ((bin % 8) + 8) % 8
	return DIRS[bin]

func _build_sprite_frames() -> SpriteFrames:
	var sf := SpriteFrames.new()
	if sf.has_animation("default"):
		sf.remove_animation("default")
	for dir in DIRS:
		var idle_name := "idle_%s" % dir
		sf.add_animation(idle_name)
		sf.set_animation_loop(idle_name, true)
		sf.set_animation_speed(idle_name, idle_speed)
		var idle_path := "%s/idle/%s/frame_0.png" % [ASSETS_ROOT, dir]
		var idle_tex: Texture2D = load(idle_path)
		if idle_tex != null:
			sf.add_frame(idle_name, idle_tex)

		var walk_name := "walk_%s" % dir
		sf.add_animation(walk_name)
		sf.set_animation_loop(walk_name, true)
		sf.set_animation_speed(walk_name, walk_speed)
		for i in range(WALK_FRAMES):
			var walk_path := "%s/walk/%s/frame_%d.png" % [ASSETS_ROOT, dir, i]
			var walk_tex: Texture2D = load(walk_path)
			if walk_tex != null:
				sf.add_frame(walk_name, walk_tex)
	return sf
