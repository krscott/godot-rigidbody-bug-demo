extends RigidBody2D


export var delay_force := true

export var __info_label_path: NodePath
onready var info_label := get_node(__info_label_path) as Label

var force := 0.0


func _ready() -> void:
	assert(info_label)

	if delay_force:
		yield(get_tree().create_timer(1), "timeout")
	force = -200.0


func _process(_delta: float) -> void:
	info_label.text = "apply_torque_impulse(%f)" % force


func _physics_process(_delta: float) -> void:
	apply_torque_impulse(force)
