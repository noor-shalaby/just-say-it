class_name Buttona
extends Button


@export var hover_scale: float = 1.1
@export var hover_animation_duration: float = 0.1
@export var unhover_animation_duration: float = 0.2
@export var pop_on_pressed: bool = false
@export var pop_scale: float = 1.5

var tween: Tween


func _ready() -> void:
	# Center origin pivot
	set_deferred("pivot_offset", size / 2)


func refresh_tween() -> void:
	if tween:
		tween.kill()
	tween = create_tween()


func focus() -> void:
	# Scale up
	refresh_tween()
	tween.tween_property(self, "scale", Vector2.ONE * hover_scale, hover_animation_duration)

func unfocus() -> void:
	# Scale down
	refresh_tween()
	tween.tween_property(self, "scale", Vector2.ONE, unhover_animation_duration)


# Scale up and then back down slowly
func pop_animation(dur: float = 0.1) -> void:
	var _tween: Tween = create_tween()
	var pre_anim_scale: Vector2 = scale
	_tween.tween_property(self, "scale", Vector2.ONE * pop_scale, dur / 2)
	_tween.tween_property(self, "scale", pre_anim_scale, dur)


func _on_pressed() -> void:
	if pop_on_pressed:
		pop_animation()


func _on_mouse_entered() -> void:
	focus()

func _on_mouse_exited() -> void:
	unfocus()


func _on_resized() -> void:
	set_deferred("pivot_offset", size / 2)
