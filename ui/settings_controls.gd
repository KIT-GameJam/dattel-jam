extends VBoxContainer

var controls_container: ControlsContainer = null

func _mode_name(mode: Window.Mode) -> String:
	match mode:
		Window.Mode.MODE_EXCLUSIVE_FULLSCREEN: return "Exclusive Fullscreen"
		Window.Mode.MODE_FULLSCREEN: return "Fullscreen"
		_: return "Windowed"

func _mode_next(mode: Window.Mode) -> Window.Mode:
	match mode:
		Window.Mode.MODE_EXCLUSIVE_FULLSCREEN: return Window.Mode.MODE_FULLSCREEN
		Window.Mode.MODE_FULLSCREEN: return Window.Mode.MODE_WINDOWED
		_: return Window.Mode.MODE_EXCLUSIVE_FULLSCREEN

func _sync_mode() -> void:
	$WindowModeButton.text = "Window Mode: " + _mode_name(get_window().mode)

func _sync_slider(slider: HSlider, bus_name: String) -> void:
	slider.set_value_no_signal(AudioServer.get_bus_volume_linear(AudioServer.get_bus_index(bus_name)))

func _ready() -> void:
	_sync_mode()
	_sync_slider($GridContainer/VolumeSlider, "Master")
	_sync_slider($GridContainer/MotorVolumeSlider, "Motor")
	_sync_slider($GridContainer/MusicVolumeSlider, "Music")

func _on_back_button_on_click() -> void:
	controls_container.pop_controls()

func _on_window_mode_button_on_click() -> void:
	var window := get_window()
	window.mode = _mode_next(window.mode)
	_sync_mode()

func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), value)

func _on_motor_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Motor"), value)

func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), value)
