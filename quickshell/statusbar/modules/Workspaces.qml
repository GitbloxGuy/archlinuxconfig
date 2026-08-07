import QtQuick
import Quickshell
import Quickshell.Hyprland

Row {
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
    }
}
