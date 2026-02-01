extends Node


func load_scene_to_monitors(scene: PackedScene) -> void:
	var instance = scene.instantiate()
	
	for mapping: String in Global.monitor_mappings:
		var monitor: MonitorMesh = Global.monitor_mappings[mapping]
		remove_children(monitor.sub_viewport)
		
		var monitor_node := instance.find_child(mapping)
		if monitor_node != null:
			monitor_node.reparent(monitor.sub_viewport)
	
	instance.queue_free()


func remove_children(node: Node) -> void:
	for child: Node in node.get_children():
		node.remove_child(node)
		child.queue_free()


func quit() -> void:
	AudioServer.lock()
	get_tree().quit()
