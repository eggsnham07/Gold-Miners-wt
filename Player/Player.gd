extends KinematicBody2D

var speed : int = 200
var jumpForce:int = 600
var gravity:int = 1000

var vel:Vector2 = Vector2()

onready var sprite = $Sprite
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	vel.x = 0
	vel.y += gravity * delta
	
	if Input.is_action_pressed("Left"):
		vel.x -= speed
		
	if Input.is_action_pressed("Right"):
		vel.x += speed
		
	if Input.is_action_pressed("Jump") and is_on_floor():
		vel.y -= jumpForce
		
	if vel.x < 0:
		sprite.flip_h = false
	elif vel.x > 0:
		sprite.flip_h = true
		
	vel = move_and_slide(vel, Vector2.UP)
