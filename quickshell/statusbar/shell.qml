import QtQuick
import Quickshell
import Quickshell.Io
import "./modules"
 ShellRoot {
PanelWindow {
id: bar
anchors {
top: true
left: true
right: true
}
implicitHeight: 28
color: "transparent"
exclusiveZone: 28
  // --- Workspaces (Left) ---
Workspaces {
anchors.verticalCenter: parent.verticalCenter
anchors.left: parent.left
anchors.leftMargin: 10
}
  // --- Clock (Center) ---
Clock {
anchors.centerIn: parent
}
  // --- Right Side Widgets ---
Row {
id: rightRow
anchors.verticalCenter: parent.verticalCenter
anchors.right: parent.right
anchors.rightMargin: 10
spacing: 12
  NetworkButton {}
CpuUsage {}
GpuUsage {}
Temps {}
VolumeControl {}
BatteryStatus {}
TrayMenu { barWindow: bar }
}
}
  // Toggle bar visibility via IPC
IpcHandler {
target: "bar"
function toggle(): void {
bar.visible = !bar.visible;
}}}
