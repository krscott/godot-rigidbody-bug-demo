# godot-rigidbody-bug-demo
A demo of a potential bug with RigidBody2D.

## Environment
Godot v3.2.2.stable.official

## Description
It seems like if a RigidBody2D is sleeping, it can not be affected by apply_impulse_torque().

In this demo, there are two spinning paddles running `apply_torque_impulse` every frame (See [Paddle.gd](Paddle.gd)).
The paddle on the right has a force applied to it immediately.
The paddle on the left has the same force applied after a 1-second timer is elapsed. Even after the force is applied,
it does not move until it is 'kick-started' by the falling box.

HTML5 demo: https://krscott.github.io/godot-rigidbody-bug-demo/

![demo gif](https://github.com/krscott/godot-rigidbody-bug-demo/blob/master/demo.gif?raw=true)


## Root Cause
It looks like `apply_torque_impulse` does not wake a sleeping RigidBody2D despite what the documentation [implies](https://docs.godotengine.org/en/stable/classes/class_rigidbody2d.html#class-rigidbody2d-property-sleeping) (but *technically* only says `apply_impulse` wakes a sleeping body).

## Workaround
Disabling `can_sleep`, even just momentarily, fixes the issue. Here is a drop-in wrapper function that fixes the issue, while preserving the functionality of `can_sleep` otherwise:
```
func apply_torque_impulse(torque: float) -> void:
	.apply_torque_impulse(torque)
	if not is_zero_approx(torque):
		var original_can_sleep := can_sleep
		can_sleep = false
		can_sleep = original_can_sleep
```

![fixed demo gif](https://github.com/krscott/godot-rigidbody-bug-demo/blob/master/demo-workaround.gif?raw=true)
