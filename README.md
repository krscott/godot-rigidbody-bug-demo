# godot-rigidbody-bug-demo
A demo of a potential bug with RigidBody2D.

## Description
It seems like if a RigidBody2D is stationary for a while, it can no longer be affected by apply_impulse_torque().

In this demo, there are two spinning paddles. The paddle on the right has a force applied to it immediately.
The paddle on the left has the same force applied after a 1-second timer is elapsed. Even after the force is applied,
it does not move until it is 'kick-started' by the falling box.

HTML5 demo: https://krscott.github.io/godot-rigidbody-bug-demo/

![demo gif](https://github.com/krscott/godot-rigidbody-bug-demo/blob/master/demo.gif?raw=true)
