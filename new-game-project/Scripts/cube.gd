extends CharacterBody3D

@onready var ai_controller: Node3D = $AIController3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	velocity.x = ai_controller.move.x
	velocity.z = ai_controller.move.y

	move_and_slide()


func _on_target_body_entered(_body: Node3D) -> void:
	position = Vector3(-2.021, 0.422, -0.204)
	ai_controller.reward += 10


func _on_walls_body_entered(_body: Node3D) -> void:
	position = Vector3(-2.021, 0.422, -0.204)
	ai_controller.reward -= 9


func _on_timer_timeout() -> void:
	ai_controller.reward -= 0.1


func _on_timer_2_timeout() -> void:
	position = Vector3(-2.021, 0.422, -0.204)
	ai_controller.reward -= 5

	
