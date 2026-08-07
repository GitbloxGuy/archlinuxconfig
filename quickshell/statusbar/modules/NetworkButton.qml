import QtQuick
import Quickshell.Io

Text {
    id: netText
    color: "#ebdbb2"
    font.family: "JetBrainsMono Nerd Font"
    font.pixelSize: 13
    text: "󰤭 "   // default: disconnected, until first poll comes back

    Process {
        id: nmtuiProc
        command: ["kitty", "--title", "nmtui-float", "-o", "initial_window_width=300", "-o", "initial_window_height=200", "-e", "nmtui"]
    }

    // Polls nmcli for connection state + wifi signal strength
    Process {
        id: netStatusProc
        command: ["sh", "-c", "nmcli -t -f TYPE,STATE,SIGNAL device | grep -E '^(wifi|ethernet)' | head -1"]
        stdout: SplitParser {
            onRead: data => {
                if (!data || data.trim() === "") {
                    netText.text = "󰤭 "   // no device found
                    return
                }
                var parts = data.trim().split(":")
                var type = parts[0]
                var state = parts[1]
                var signal = parseInt(parts[2]) || 0

                if (state !== "connected") {
                    netText.text = "󰤭 "   // disconnected
                } else if (type === "ethernet") {
                    netText.text = "󰈀 "   // wired connection
                } else if (signal >= 75) {
                    netText.text = "󰤨 "   // wifi strong
                } else if (signal >= 50) {
                    netText.text = "󰤥 "   // wifi medium
                } else if (signal >= 25) {
                    netText.text = "󰤢 "   // wifi weak
                } else {
                    netText.text = "󰤯 "   // wifi very weak
                }
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: netStatusProc.running = true
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            nmtuiProc.running = false
            nmtuiProc.running = true
        }
    }
}
