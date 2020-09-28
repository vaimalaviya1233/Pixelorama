class_name TextToolEdit
extends TextEdit

var font: DynamicFont setget _font_changed
var drag := false


func _ready() -> void:
	theme = Global.control.theme
	if font:
		rect_min_size = Vector2(32, max(32, font.get_height()))
		rect_size.y = get_line_count() * font.get_height() + 16


func _on_Drag_gui_input(event: InputEvent) -> void:
	if not drag or not event is InputEventMouseMotion:
		return
	rect_position += event.relative


func _font_changed(value: DynamicFont) -> void:
	font = value
	add_font_override("font", font)


func _on_TextToolEdit_text_changed() -> void:
	if not font:
		return
	rect_size.x = 16 + font.get_string_size(get_line(_get_max_line())).x
	rect_size.y = get_line_count() * font.get_height() + 16


func _get_max_line() -> int:
	var max_line: int = 0
	var max_string: int = get_line(0).length()
	for i in get_line_count():
		var line := get_line(i)
		if line.length() > max_string:
			max_string = line.length()
			max_line = i

	return max_line


func _on_Drag_button_down() -> void:
	drag = true


func _on_Drag_button_up() -> void:
	drag = false
	grab_focus()
