extends Node
class_name Movement
var speed
var transform
var velocity

func _init(_speed, _transform, _velocity: Vector3):
	speed = _speed
	transform = _transform
	velocity = _velocity * -1
