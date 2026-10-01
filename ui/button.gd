@tool
extends PanelContainer

@export_multiline var text: String = "Test mit Asbest":
	set(val):
		if text == val: return
		text = val
		if label_node != null: sync_text()

@onready var button_node: Button = $Button
@onready var label_node: RichTextLabel = $HBoxContainer/MarginContainer/RichTextLabel

signal on_click()

var effect: JumpingLettersEffect = null

func sync_text() -> void:
	label_node.clear()
	label_node.push_customfx(effect, {})
	label_node.add_text(text)
	label_node.pop()

func _ready() -> void:
	effect = JumpingLettersEffect.new()
	effect.label = label_node
	effect.button = button_node
	effect.active = false
	sync_text()

func _process(_delta: float) -> void:
	effect.active = button_node.is_hovered() or button_node.has_focus(true)

func _on_button_pressed() -> void:
	on_click.emit()
