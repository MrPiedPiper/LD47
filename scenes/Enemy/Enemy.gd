extends Node2D

signal move_to_front
signal move_to_back

export(NodePath) var path
export var is_looping = false
export var score = 1
export var health = 1

enum DIFFICULTY {
	EASY=1,
	MEDIUM=2,
	HARD=3,
}
export(DIFFICULTY) var difficulty = DIFFICULTY.EASY

var max_speed = 480
var speed = max_speed / 8
var velocity = Vector2(0,0)
var target = Vector2(0,0)

var touching_enemies = []

var curve
var points = []
var midway
var is_front = false

func _ready():
	randomize()
	var seek = rand_range(0,1.6)
	$AnimationPlayer.play("Fly")
	$AnimationPlayer.seek(seek,true)
	if path != null and path != null and path.curve != null:
		curve = path.curve
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
	if target == null or points.size() == 0:
		return
	velocity += (target - position).normalized() * speed	
	velocity = velocity.clamped(max_speed)
	rotation = velocity.angle()
	position += velocity * delta 
	if position.distance_to(target) < 100:
		if is_looping:
			points.insert(0,points.pop_back())
		else:
			points.remove(0)
			if points.size() == 0:
				queue_free()
				return
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

func damage(amount:int):
	health -= amount
	if health <= 0:
		queue_free()











