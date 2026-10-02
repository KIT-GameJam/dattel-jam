extends Node

@onready var walz_pfad : Path2D = $WalzPfad

func _ready() -> void:

	for child: Road in find_children("*", "Road"):
		var curve = child.path.curve
		for point_idx in range(curve.point_count):
			var local_point = curve.get_point_position(point_idx)
			var global_point = child.global_transform * local_point # or global_transform.xform(local_point)
			var target_local_point = walz_pfad.global_transform.affine_inverse() * global_point

			walz_pfad.curve.add_point(
				target_local_point,
				Vector2(0, 0), # TODO handle in and out points correctly
				Vector2(0, 0),
			)

	print()
