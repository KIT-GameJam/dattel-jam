extends GhostCar

func _on_barrier_collision(body: Node2D) -> void:
	if body is PlayerCar:
		body.die()
