extends GutTest


func test_damage_teams_classify_allies_and_enemies() -> void:
	var player := ResourceDamageTeam.new()
	player.team = ResourceDamageTeam.Team.PLAYER
	player.ally_team = [ResourceDamageTeam.Team.PLAYER, ResourceDamageTeam.Team.NPC]
	var npc := ResourceDamageTeam.new()
	npc.team = ResourceDamageTeam.Team.NPC
	var enemy := ResourceDamageTeam.new()
	enemy.team = ResourceDamageTeam.Team.ENEMY

	assert_true(player.is_ally(npc))
	assert_true(player.is_enemy(enemy))


func test_camera_grid_round_trips_authored_cells() -> void:
	var camera := CameraGrid.new()
	camera.grid_size = Vector2(320, 176)

	assert_eq(camera.grid_to_world(Vector2(2, -1)), Vector2(640, -176))
	assert_eq(camera.world_to_grid(Vector2(640, -176)), Vector2(2, -1))
	camera.free()
