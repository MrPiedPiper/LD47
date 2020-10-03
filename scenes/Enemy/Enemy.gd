extends Node2D

signal move_to_front
signal move_to_back

export(NodePath) var path

var speed = 8
var max_speed = 150
var velocity = Vector2(0,0)
var target = Vector2(0,0)

var touching_enemies = []

onready var curve = get_node(path).curve
var points = []
var midway
var is_front = false

func _ready():
	var highest
	var lowest
	for i in range(curve.get_point_count()):
		var curr_point = curve.get_point_position(i)
		points.append(curr_point)
		if highest == null or highest < curr_point.y:
			highest = curr_point.y
		if lowest == null or highest > curr_point.y:
			lowest = curr_point.y
	midway = (highest + lowest)/2
	target = points[0]

func _physics_process(delta):
	velocity += (target - position).normalized() * speed
	
#	for i in touching_enemies:
#		velocity += -(i.position - position).normalized() * 4
	
	velocity = velocity.clamped(max_speed)
	rotation = velocity.angle()
	position += velocity * delta 
	if position.distance_to(target) < 100:
		points.insert(0,points.pop_back())
		target = points[0]
		if target.y > midway and !is_front:
			is_front = true
			emit_signal("move_to_front",self)
		elif target.y < midway and is_front:
			emit_signal("move_to_back",self)
			is_front = false

func _on_Area2D_area_entered(area):
	if area.owner.is_in_group("enemy"):
		touching_enemies.append(area)

func _on_Area2D_area_exited(area):
	if area == null or area.owner == null:
		return
	if area.owner.is_in_group("enemy"):
		touching_enemies.erase(area)

func _on_Area2DHitbox_area_entered(area):
	if area.is_in_group("attack") and area.owner.is_in_group("player"):
		touching_enemies.erase(area)
		queue_free()











