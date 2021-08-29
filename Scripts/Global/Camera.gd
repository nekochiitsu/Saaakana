extends Camera2D

onready var Player1 = get_node("../../../Entities/Player 1")
onready var Player2 = get_node("../../../Entities/Player 2")
onready var UI = $UI
onready var P1Hp = $UI/P1/FontHp/Hp
onready var P1Q = $UI/P1/FontAuto/Auto
onready var P2Hp = $UI/P2/FontHp/Hp
onready var P2Q = $UI/P2/FontAuto/Auto

var Rotate = 0
var sensi = 0.3
var SmoothCamera = 2
var lastPos = Vector2()
var CameraPosition = Vector2()
var PlayerDistance = 0
var Zoom = [0.3, 0.3]
var lastZoom = 1
var UnZoom = 0

func get_imput(delta):
	if Input.is_action_pressed("Zoom [+]"):
		Zoom[0] -= delta + (Zoom[0] / 100)
		Zoom[1] -= delta + (Zoom[1] / 100)
	if Input.is_action_pressed("Zoom [-]"):
		Zoom[0] += delta + (Zoom[0] / 100)
		Zoom[1] += delta + (Zoom[1] / 100)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	get_imput(delta)
	
	CameraPosition = (Player1.get_position() + Player2.get_position())/2
	
	PlayerDistance = CameraPosition - Player2.get_position()
	PlayerDistance.x *= 0.54545454
	if PlayerDistance.x < 0:
		PlayerDistance.x = -PlayerDistance.x
	if PlayerDistance.y < 0:
		PlayerDistance.y = -PlayerDistance.y
	if PlayerDistance.x > PlayerDistance.y:
		PlayerDistance = PlayerDistance.x
	else:
		PlayerDistance = PlayerDistance.y
	if PlayerDistance < 100:
		PlayerDistance = 100
	zoom.x = ((Zoom[0] * (PlayerDistance / 100)) + lastZoom*2) / 3
	zoom.y = ((Zoom[1] * (PlayerDistance / 100)) + lastZoom*2) / 3
	UI.set_scale(zoom)
	
	position = (CameraPosition + lastPos * 10) / 11
	UI.set_position((position - lastPos) * 5)
	P1Hp.set_size(Vector2((Player1.Hp * 500) / Player1.MaxHp, 16))
	P1Q.set_size(Vector2(Player1.Q, 12))
	P2Hp.set_size(Vector2((Player2.Hp * 500) / Player2.MaxHp, 16))
	P2Q.set_size(Vector2(Player2.Q, 12))
	lastPos = position
	lastZoom = zoom.x
	rotation = Rotate
