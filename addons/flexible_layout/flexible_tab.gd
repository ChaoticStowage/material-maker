extends Container


var flex_panel : Control


func _ready():
	$Container/Close.texture_normal = get_theme_icon("close", "TabBar")

func init(fp : Control):
	flex_panel = fp
	$Container/Label.text = flex_panel.name

func _draw():
	var is_current : bool = (get_index() == get_parent().get_parent().current)
	draw_style_box(get_theme_stylebox("tab_selected" if is_current else "tab_unselected", "TabBar"), Rect2(Vector2(), size))
	#$Container/Undock.visible = is_current
	$Container/Close.visible = is_current

func _on_close_pressed():
	var flex_tab = get_parent().get_parent().get_flex_tab()
	flex_tab.remove(flex_panel)
	flex_tab.flexible_layout.layout()

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		get_parent().get_parent().set_current(get_index())

func _get_drag_data(_position):
	var flex_tab = get_parent().get_parent().get_flex_tab()
	var flexible_layout = flex_tab.flexible_layout
	return flexible_layout.PanelInfo.new(flex_tab, flex_panel)
