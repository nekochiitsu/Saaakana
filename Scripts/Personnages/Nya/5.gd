extends Node2D

""""""
onready var flaque = preload("res://Scenes/Personnages/Nya/flaque.tscn")
var launcher = []
var velocity = Vector2(1, 0)
var speed = 4
var End = 0
var collision = false
var is_projectile = false
var damage
var collisionLayer
var ExpectedPos
var flaque_
var iniDist
var scale_
""""""

# Fonction d'Init
func Launch(LauncherPosition: Vector2, LauncherDirection, _Damage, CollisionLayer, ExpectedPos_):
	visible = false
	position = LauncherPosition
	rotation_degrees = LauncherDirection
	velocity = Vector2(1, 0).rotated(rotation)
	damage = _Damage
	collisionLayer = CollisionLayer
	ExpectedPos = ExpectedPos_
	iniDist = get_global_position().distance_to(ExpectedPos)
	print(iniDist)
	"""
	if -90 < rotation_degrees and rotation_degrees < 90:
		position += Vector2(8, -14).rotated(rotation)
	else:
		self.flip_v = true
		position += Vector2(8, 14).rotated(rotation)
	"""
	visible = true

func _process(delta):
	if get_global_position().distance_to(ExpectedPos) < (speed * (delta * 60)):
		EndAnimWaiter()
	else:
		position += (velocity * speed * (delta * 60))
		scale_ = (1+3*(sin(get_global_position().distance_to(ExpectedPos)*PI/iniDist)))
		print(get_global_position().distance_to(ExpectedPos))
		scale = Vector2(scale_, scale_)

# Application des dégats
func EndAnimWaiter():
	flaque_ = flaque.instance()
	get_parent().add_child(flaque_)
	flaque_.Launch(ExpectedPos, damage, collisionLayer)
	queue_free()
