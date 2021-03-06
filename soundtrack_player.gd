extends Control

var selector
var selector_position
var current_map
var map_pos
var game_scale
var units
var unit_selected = false
var action_controller
var soundtrack_player

func _input(event):
# UPDATE LIVE STUFF
	if (event.type == InputEvent.MOUSE_MOTION or event.type == InputEvent.MOUSE_BUTTON):
		units = get_tree().get_nodes_in_group("units")
		map_pos = current_map.get_pos()
		selector_position = current_map.world_to_map( Vector2((event.x/game_scale.x)-map_pos.x,(event.y/game_scale.y)-map_pos.y))

# MOUSE MOVE
	if (event.type == InputEvent.MOUSE_MOTION):
		
		var position = current_map.map_to_world(selector_position)
		position.y += 2
		selector.set_pos(position)

# MOUSE SELECT
	if (event.type == InputEvent.MOUSE_BUTTON):
		if (event.pressed and event.button_index == BUTTON_LEFT):
			action_controller.handle_action(selector_position)
	
	if Input.is_action_pressed('ui_cancel'):
		action_controller.clear_active_field()

#func _process(delta):
	# do realtime stuff here

func _ready():
	selector = get_node('/root/game/pixel_scale/map/YSort/selector')
	current_map = get_node("/root/game/pixel_scale/map")
	game_scale = get_node("/root/game/pixel_scale").get_scale()
	action_controller = preload("action_controller.gd").new()
	soundtrack_player = get_node("/root/game/StreamPlayer")
	soundtrack_player.play()
	
	var music_player = StreamPlayer.new()
	var stream = Resource.load("aliens.ogg")
	stream.set_path(song)
	music_player.set_stream(stream)
	music_player.play()
		
	action_controller.init_root(self)
	action_controller.switch_to_player(0)
	set_process_input(true)
	pass


