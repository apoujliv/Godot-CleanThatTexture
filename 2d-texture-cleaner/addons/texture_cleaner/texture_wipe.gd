@tool
extends Control

@export var front_image : Texture2D
@export var enable_background_image : bool = true
@export var back_image : Texture2D
@export var line_width : int = 50
@export var wait_time: float = 5
@export var enable_emitter: bool = true
@export var max_point_count: int = 250
@export var emitter_import: GPUParticles2D

var current_points: int = 0;

#brush radius
var brush_radius = Vector2(20, 20)
var brush_node : Line2D
var front_image_node : TextureRect
var back_image_node : TextureRect
var final_image_node : TextureRect
var particle_emitter : GPUParticles2D
var timer : Timer
var time_left : int

#handle mouse input and draw while dragging
var dragging: bool = false
var mouse_in_range_front: bool = false
var mouse_in_range_back: bool = false

var is_first_pass: bool = true
var is_finished: bool = false

func _enter_tree():
	brush_node = get_node_or_null("Line2D")
	brush_node.width = .01
	brush_node.add_point(brush_node.points[0])

	front_image_node = get_node_or_null("FrontImage")
	back_image_node = brush_node.get_node_or_null("BackImage")
	final_image_node = get_parent().get_node_or_null("FinalImage")
	final_image_node.position = back_image_node.position

	if (enable_background_image && back_image != null):	
		back_image_node.texture = back_image
	else:
		back_image_node.visible = false
		final_image_node.visible = false
	if (front_image != null):
		front_image_node.texture = front_image
	
	timer = get_parent().get_node_or_null("Timer")
	
	if (wait_time != null):
		timer.wait_time = wait_time
		time_left = wait_time
	
	if (enable_emitter):
		if emitter_import != null:
			particle_emitter = emitter_import
		else:
			particle_emitter = get_parent().get_node_or_null("Emitter")
	
	queue_redraw()


func _exit_tree():
	# Clean-up of the plugin goes here.
	pass
	
func _process(delta: float) -> void:
	if !is_finished:
		if dragging:
			if _is_mouse_in_range():
				clean_surface()
	queue_redraw()

func clean_surface():	
	if current_points > max_point_count:
		fade_out()
		
	var mouse_pos = get_global_mouse_position()
	if is_first_pass && brush_node.width != line_width:
		is_first_pass = false
		brush_node.width = line_width
		brush_node.set_point_position(0, mouse_pos)
		timer.start(time_left)
	elif _is_mouse_in_range():
		brush_node.add_point(mouse_pos)
		if enable_emitter:
			particle_emitter.position = mouse_pos
	
	if _is_mouse_in_range() && brush_node.points.size() > 0:
		brush_node.set_point_position(brush_node.points.size()-1,mouse_pos)
		if enable_emitter:
			particle_emitter.position = mouse_pos 
			
	current_points = brush_node.get_point_count()

func fade_out() -> void:
	timer.stop()
	var tween = create_tween()
	await tween.tween_property(self, "modulate", Color.TRANSPARENT, 2)
	if enable_emitter:
		particle_emitter.emitting = false
	is_finished = true;
	
func _handle_drag(event: InputEvent) -> void:
	#handles input so we can brush
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				dragging = true
				if enable_emitter:
					particle_emitter.emitting = true
				timer.start(time_left)
				get_viewport().set_input_as_handled()
			elif event.is_released():
				dragging = false
				if enable_emitter:
					particle_emitter.emitting = false
				time_left = timer.time_left
				timer.stop()
				get_viewport().set_input_as_handled()

func _is_mouse_in_range() -> bool:
	return mouse_in_range_back || mouse_in_range_front

func _on_back_image_mouse_entered() -> void:
	mouse_in_range_back = true

func _on_back_image_mouse_exited() -> void:
	mouse_in_range_back = false

func _on_front_image_mouse_entered() -> void:
	mouse_in_range_front = true

func _on_front_image_mouse_exited() -> void:
	mouse_in_range_front = false

func _on_back_image_gui_input(event: InputEvent) -> void:
	_handle_drag(event)

func _on_front_image_gui_input(event: InputEvent) -> void:
	_handle_drag(event)

func _unhandled_input(event: InputEvent) -> void:
	_handle_drag(event)

func _on_timer_timeout() -> void:
	fade_out()
