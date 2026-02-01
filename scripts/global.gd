extends Node


var main_monitor: MonitorMesh
var top_monitor: MonitorMesh
var side_monitor: MonitorMesh
var monitor_mappings := {}


func init_monitor_mappings() -> void:
	monitor_mappings = {
		"MainMonitor": main_monitor,
		"TopMonitor": top_monitor,
		"SideMonitor": side_monitor
	}
