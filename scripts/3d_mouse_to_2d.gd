extends MeshInstance3D


@export var sub_viewport: SubViewport


# if its not a plane what are we doing bro
@onready var plane_mesh: PlaneMesh = mesh


const RAY_DISTANCE: float = 1000.0


var triangle_1: Array[Vector3] = []
var triangle_2: Array[Vector3] = []


func _ready() -> void:
	triangle_1 = [
		Vector3.ZERO,
		Vector3.RIGHT * plane_mesh.size.x,
		Vector3.DOWN * plane_mesh.size.y
	]
	triangle_2 = [
		Vector3(plane_mesh.size.x, -plane_mesh.size.y, 0),
		Vector3.RIGHT * plane_mesh.size.x,
		Vector3.DOWN * plane_mesh.size.y
	]

	for i in range(triangle_1.size()):
		triangle_1[i] -= Vector3(plane_mesh.size.x, -plane_mesh.size.y, 0) / 2
		triangle_2[i] -= Vector3(plane_mesh.size.x, -plane_mesh.size.y, 0) / 2
		triangle_1[i] = global_transform * triangle_1[i]
		triangle_2[i] = global_transform * triangle_2[i]
	

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		var viewport := get_viewport()
		var camera: Camera3D = viewport.get_camera_3d()

		var screen_point := viewport.get_mouse_position()
		var from_pos := camera.project_ray_origin(screen_point)
		var direction := camera.project_ray_normal(screen_point) * RAY_DISTANCE
		
		var intersects_triangle_1 = Geometry3D.ray_intersects_triangle(
			from_pos,
			direction,
			triangle_1[0],
			triangle_1[1],
			triangle_1[2]
		)
		var intersects_triangle_2 = Geometry3D.ray_intersects_triangle(
			from_pos,
			direction,
			triangle_2[0],
			triangle_2[1],
			triangle_2[2]
		)

		if intersects_triangle_1 != null or intersects_triangle_2 != null:
			var hit_pos := Vector3.ZERO
			if intersects_triangle_1 != null:
				hit_pos = intersects_triangle_1
			else:
				hit_pos = intersects_triangle_2

			if hit_pos == null:
				# ????
				return
			
			hit_pos = global_transform.affine_inverse() * hit_pos
			
			var screen_uv := Vector2(hit_pos.x, hit_pos.y)

			# convert to 0.0-1.0 rather than -1.0, 1.0
			screen_uv += Vector2(1.0, 1.0)
			screen_uv /= 2

			screen_uv.y = 1 - screen_uv.y
			event.position = screen_uv * Vector2(sub_viewport.size)
			sub_viewport.push_input(event, false)
