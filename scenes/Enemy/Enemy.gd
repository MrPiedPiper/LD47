extends Node2D

export(NodePath) var path

var speed = 8
var max_speed = 150
var velocity = Vector2(0,0)
var target = Vector2(0,0)

var touching_enemies = []

onready var curve = get_node(path).curve
var points = []

func _ready():
	for i in range(curve.get_point_count()):
		points.append(curve.get_point_position(i))
	target = points[0]

func _physics_process(delta):
	velocity += (target - position).normalized() * speed
	
#	for i in touching_enemies:
#		velocity += -(i.position - position).normalized() * 4
	
	velocity = velocity.clamped(max_speed)
	position += velocity * delta 
	if position.distance_to(target) < 100:
		points.insert(0,points.pop_back())
		target = points[0]

func _on_Area2D_area_entered(area):
	if area.owner.is_in_group("enemy"):
		touching_enemies.append(area)

func _on_Area2D_area_exited(area):
	if area.owner.is_in_group("enemy"):
		touching_enemies.erase(area)










