extends RigidBody2D


export var delay_force := true
export var workaround := true

export var __info_label_path: NodePath
onready var info_label := get_node(__info_label_path) as Label

var torque := 0.0


func _ready() -> void:
	assert(info_label)

	if delay_force:
		yield(get_tree().create_timer(1), "timeout")
	torque = -200.0


func _process(_delta: float) -> void:
	info_label.text = "apply_torque_impulse(%f)" % torque


func _physics_process(_delta: float) -> void:
	if workaround:
		apply_torque_impulse(torque)
	else:
		.apply_torque_impulse(torque)


func apply_torque_impulse(torque: float) -> void:
	.apply_torque_impulse(torque)
	if not is_zero_approx(torque):
		var original_can_sleep := can_sleep
		can_sleep = false
		can_sleep = original_can_sleep
