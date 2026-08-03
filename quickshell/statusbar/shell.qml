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

        // --- Workspaces (Left) ---
        Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            spacing: 8

        Repeater {
    	model: Hyprland.workspaces

	Item {
        width: modelData.id > 0 ? 28 : 0
        height: 24
        visible: modelData.id > -9999

        Column {
            anchors.centerIn: parent
            spacing: 1

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: modelData.id
                color: modelData.active ? "#fabd2f" : "#ebdbb2"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                font.bold: modelData.active
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 16
                height: 1
                radius: 1
                color: "#fabd2f"
                visible: modelData.active
            }
        }
    }
}        }

        // --- Clock (Center) ---
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

        // --- Right Side Widgets ---
        Row {
            id: rightRow
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            spacing: 12

            PwObjectTracker {
                objects: [Pipewire.defaultAudioSink]
            }

            // Network Manager GUI Launcher Process
            Process {
                id: nmtuiProc
                command: ["kitty", "--title", "nmtui-float", "-o", "initial_window_width=300", "-o", "initial_window_height=200", "-e", "nmtui"]
            }

            // Dedicated WiFi/Network Button
            Text {
                color: "#ebdbb2"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                text: "󰤨 "

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: nmtuiProc.running = true
                }
            }

            // CPU Usage Block
            Text {
                id: cpuText
                color: "#ebdbb2"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                text: " --%"

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
                                cpuText.text = " " + usage + "%";
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

            // Volume Block
            Text {
                color: "#ebdbb2"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                text: {
                    var sink = Pipewire.defaultAudioSink;
                    if (!sink || !sink.audio) return "󰕾 --%";
                    var vol = Math.round(sink.audio.volume * 100);
                    return sink.audio.muted ? "󰝟 " : "󰕾 " + vol + "%";
                }

                MouseArea {
                    anchors.fill: parent
                    onWheel: (wheel) => {
                        var sink = Pipewire.defaultAudioSink;
                        if (!sink || !sink.audio) return;
                        if (wheel.angleDelta.y > 0) {
                            sink.audio.volume = Math.min(1.0, sink.audio.volume + 0.05);
                        } else {
                            sink.audio.volume = Math.max(0.0, sink.audio.volume - 0.05);
                        }
                    }
                }
            }

            // Battery Block
            Text {
                color: "#ebdbb2"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                text: {
                    let d = UPower.displayDevice;
                    if (!d) return "󰁹 --%";
                    let prefix = d.charging ? "󰂄 " : "󰁹 ";
                    return prefix + Math.round(d.percentage * 100) + "%";
                }
            }

            // --- System Tray Popup Toggle Button ---
            Text {
                id: trayToggle
                color: trayPopup.visible ? "#fabd2f" : "#ebdbb2"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 14
                text: "󰍜 " // Drawer/Menu Icon

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: trayPopup.visible = !trayPopup.visible
                }
            }
        }

        // --- System Tray Popout Menu ---
        PopupWindow {
            id: trayPopup
            anchor.window: bar
            anchor.rect.x: bar.width - width - 10
            anchor.rect.y: bar.height + 4
            visible: false
	    color: "transparent"

	Connections {
                target: Hyprland
                function onFocusedWindowChanged() {
                    trayPopup.visible = false;
                }
            }

            Rectangle {
                width: trayRow.implicitWidth + 16
                height: 36
                color: "#282828"
                border.color: "#3c3836"
                border.width: 1
                radius: 6

                Row {
                    id: trayRow
                    anchors.centerIn: parent
                    spacing: 8

                    // Notice text if no tray icons are running
                    Text {
                        visible: SystemTray.items.length === 0
                        text: "No active applets"
                        color: "#928374"
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 11
                    }

                    Repeater {
                        model: SystemTray.items

                        Image {
                            width: 20
                            height: 20
                            source: modelData.icon

                            MouseArea {
                                anchors.fill: parent
                                acceptedButtons: Qt.LeftButton | Qt.RightButton
                                onClicked: (mouse) => {
                                    if (mouse.button === Qt.RightButton) {
                                        modelData.displayMenu();
                                    } else {
                                        modelData.activate();
				    }
				trayPopup.visible = false;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Toggle bar visibility via IPC
    IpcHandler {
        target: "bar"
        function toggle(): void {
            bar.visible = !bar.visible;
        }
    }
}
