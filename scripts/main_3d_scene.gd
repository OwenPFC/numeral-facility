extends Node3D


func _ready():
	Global.main_monitor = $MainMonitor/GameMesh
	Global.top_monitor = $TopMonitor/GameMesh
	Global.side_monitor = $SideMonitor/GameMesh
	
	Global.init_monitor_mappings()
