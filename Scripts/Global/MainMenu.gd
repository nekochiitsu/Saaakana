extends Node2D

func get_imput():
	if Input.is_action_pressed("Fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	if Input.is_action_just_pressed("Mouse Capture"):
		if Input.get_mouse_mode():
			Input.set_mouse_mode(0)
		else:
			Input.set_mouse_mode(2)

func SceneChange(Scene):
	get_parent().SceneChange("MainMenu", Scene)

func _ready():
	Input.set_mouse_mode(0)

func _process(_delta):
	get_imput()

func _on_Jouer_pressed():
	SceneChange('ChampSelect')

func _on_Quitter_pressed():
	get_tree().quit()



