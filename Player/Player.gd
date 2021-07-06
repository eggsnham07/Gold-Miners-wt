extends KinematicBody2D

var speed : int = 300
var jumpForce:int = 600
var gravity:int = 1000

var vel:Vector2 = Vector2()

onready var sprite = $Sprite
var time:int = 20

var t = Transform2D()

var dash:bool = false
var grapple:bool = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if get_tree().current_scene.name == "Tutorial":
		dash = true
		grapple = true

func _physics_process(delta):
	vel.x = 0
	vel.y += gravity * delta

	if Input.is_action_pressed("Left"):
		vel.x -= speed

	if Input.is_action_pressed("Right"):
		vel.x += speed

	if Input.is_action_pressed("Jump") and is_on_floor():
		vel.y -= jumpForce

	if Input.is_action_pressed("Sprint"):
		speed = 300

	if !Input.is_action_pressed("Sprint"):
		speed = 200
		
	if Input.is_action_pressed("Dash") and dash == true:
		if sprite.flip_h == true:
			if time > 0:
				time -= delta
				vel.x += 1000
				if !is_on_floor():
					vel.y = 0
			elif time != 0:
				vel.x = 0
				print("time is not 0")
				
		elif sprite.flip_h == false:
			if time > 0:
				time -= delta
				vel.x -= 1000

				if !is_on_floor():
					vel.y = 0
			elif time != 0:
				vel.x = 0
				print("time is not 0")
	
	if Input.is_action_pressed("Grapple") and grapple == true:
		if sprite.flip_h == true:
			#right
			if time > 0:
				time -= delta
				vel.y -= 40
				vel.x += 300
			elif time != 0:
				vel.x = 0
				vel.y = 0
				print("time is not 0")
		if sprite.flip_h == false:
			#right
			if time > 0:
				time -= delta
				vel.y -= 40
				vel.x -= 300
			elif time != 0:
				vel.x = 0
				vel.y = 0
				print("time is not 0")
				

	if vel.x < 0:
		sprite.flip_h = false
	elif vel.x > 0:
		sprite.flip_h = true

	vel = move_and_slide(vel, Vector2.UP)
	if is_on_floor() and time == 0:
		time = 20
	
func collect_dash():
	dash = true
