import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

ShellRoot {
    PanelWindow {
        id: menu
        WlrLayershell.namespace: "powermenu"
        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }
        color: "#cc282828"
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

        FocusScope {
            anchors.fill: parent
            focus: true
            Keys.onEscapePressed: Qt.quit()

            Row {
                anchors.centerIn: parent
                spacing: 24
                Repeater {
                    model: [
                        { label: "Lock", icon: "", cmd: ["hyprctl", "dispatch", "hl.dsp.exec_cmd(\"hyprlock\")"] },
                        { label: "Logout", icon: "", cmd: ["hyprctl", "dispatch", "hl.dsp.exit()"] },
                        { label: "Suspend", icon: "", cmd: ["systemctl", "suspend"] },
                        { label: "Reboot", icon: "", cmd: ["systemctl", "reboot"] },
                        { label: "Shutdown", icon: "", cmd: ["systemctl", "poweroff"] }
                    ]
                    Rectangle {
                        width: 100
                        height: 100
                        radius: 12
                        color: mouseArea.containsMouse ? "#504945" : "#3c3836"
                        Column {
                            anchors.centerIn: parent
                            spacing: 8
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: modelData.icon
                                color: "#ebdbb2"
                                font.family: "JetBrainsMono Nerd Font"
                                font.pixelSize: 28
                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: modelData.label
                                color: "#ebdbb2"
                                font.family: "JetBrainsMono Nerd Font"
                                font.pixelSize: 12
                            }
                        }
                        Process {
                            id: actionProc
                            command: modelData.cmd
                        }
                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                actionProc.running = true
                                Qt.quit()
                            }
                        }
                    }
                }
            }
        }
    }
}
