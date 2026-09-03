extends Node

const SCHEMA_VERSION := 2

var latest_state: Dictionary = {}
var _player_origin := Vector2.ZERO
var _has_player_origin := false
var _input_mode := "keyboard"


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	_publish_state()


func _process(_delta: float) -> void:
	_publish_state()


func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		_input_mode = "touch"
	elif event is InputEventKey or event is InputEventJoypadButton or event is InputEventJoypadMotion:
		_input_mode = "keyboard"


func _publish_state() -> void:
	var player := get_tree().get_first_node_in_group("player") as CharacterBody2D
	if player and not _has_player_origin:
		_player_origin = player.global_position
		_has_player_origin = true
	var player_state := {
		"present": player != null,
		"x": snappedf(player.global_position.x, 0.1) if player else 0.0,
		"y": snappedf(player.global_position.y, 0.1) if player else 0.0,
		"moving": player.velocity.length_squared() > 1.0 if player else false,
		"moved_from_spawn": player.global_position.distance_to(_player_origin) > 2.0 if player and _has_player_origin else false,
	}
	latest_state = {
		"schema_version": SCHEMA_VERSION,
		"ready": player != null,
		"mode": "playing" if player else "loading",
		"platform": OS.get_name(),
		"input_mode": _input_mode,
		"game": {
			"scene": "world",
			"player": player_state,
		},
	}
	if OS.has_feature("web"):
		JavaScriptBridge.eval(
			"window.__POMPEII_GODOT__ = " + JSON.stringify(latest_state)
		)
