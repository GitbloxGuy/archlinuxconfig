import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.UPower
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray

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

        // Workspaces (left)
        Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            spacing: 8

            Repeater {
                model: Hyprland.workspaces

                Rectangle {
                    width: 24
                    height: 24
                    radius: 4
                    color: modelData.active ? "#fabd2f" : "#3c3836"

                    Text {
                        anchors.centerIn: parent
                        text: modelData.id
                        color: modelData.active ? "#282828" : "#ebdbb2"
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 12
                    }
                }
            }
        }

        // Clock (center)
        Text {
            anchors.centerIn: parent
            color: "#ebdbb2"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 13

            SystemClock {
                id: clock
                precision: SystemClock.Seconds
            }

            text: Qt.formatDateTime(clock.date, "ddd MMM d  hh:mm:ss AP")
        }

        // Right side: tray, cpu, volume, battery, wifi
        Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            spacing: 12

            PwObjectTracker {
                objects: [Pipewire.defaultAudioSink]
            }

            // System tray icons
            Row {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 6
                Repeater {
                    model: SystemTray.items

                    Image {
                        width: 18
                        height: 18
                        source: modelData.icon
                        MouseArea {
			anchors.fill: parent
  			onClicked: nmtuiProc.running = true
			}
		
               		Process {
                        id: nmtuiProc
                        command: ["kitty", "--title", "nmtui-float", "-o", "initial_window_width=300", "-o", "initial_window_height=200", "-e", "nmtui"]
                       }

                    }
                }
            }

            // CPU
            Text {
                id: cpuText
                color: "#ebdbb2"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                text: "  --%"

                property var lastIdle: 0
                property var lastTotal: 0

                Process {
                    id: cpuProc
                    command: ["cat", "/proc/stat"]
                    stdout: StdioCollector {
                        onStreamFinished: {
                            var line = this.text.split("\n")[0];
                            var parts = line.trim().split(/\s+/).slice(1).map(Number);
                            var idle = parts[3];
                            var total = parts.reduce((a, b) => a + b, 0);

                            var idleDelta = idle - cpuText.lastIdle;
                            var totalDelta = total - cpuText.lastTotal;

                            if (cpuText.lastTotal > 0 && totalDelta > 0) {
                                var usage = Math.round((1 - idleDelta / totalDelta) * 100);
                                cpuText.text = "  " + usage + "%";
                            }

                            cpuText.lastIdle = idle;
                            cpuText.lastTotal = total;
                        }
                    }
                }

                Timer {
                    interval: 2000
                    running: true
                    repeat: true
                    triggeredOnStart: true
                    onTriggered: cpuProc.running = true
                }
            }

            // Volume
            Text {
                color: "#ebdbb2"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                text: {
                    var sink = Pipewire.defaultAudioSink;
                    if (!sink || !sink.audio) return "   --%";
                    var vol = Math.round(sink.audio.volume * 100);
                    return sink.audio.muted ? "   Muted" : "   " + vol + "%";
                }
            }

            // Battery
            Text {
                color: "#ebdbb2"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                text: {
                    let d = UPower.displayDevice
                    if (!d) return "   --%"
                    let prefix = d.charging ? "   " : "   "
                    return prefix + Math.round(d.percentage * 100) + "%"
                }
            }

                   }
   		 }

    IpcHandler {
        target: "bar"
        function toggle(): void {
            bar.visible = !bar.visible
        }
    }
}
