
import QtQuick
import Quickshell.Io

// A self-contained GPU usage indicator (AMD/amdgpu).
// Drop <GpuUsage /> anywhere in your bar - it renders its own Text.
// Confirmed via: for hw in /sys/class/drm/card*/device/hwmon/hwmon*/temp1_input; do echo "$hw: $(cat $hw)"; done
// Your GPU is card1, not card0.
Row {
    spacing: 4

    Text {
        text: "󰢮"
        color: "#ebdbb2"
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 18   // bump this up/down to taste
	anchors.verticalCenter: parent.verticalCenter
    	anchors.verticalCenterOffset: -3  // negative = up, positive = down
    }

    Text {
        id: gpuText
        color: "#ebdbb2"
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 13
        text: "--%"

        Process {
            id: gpuProc
            command: ["sh", "-c", "cat /sys/class/drm/card1/device/gpu_busy_percent 2>/dev/null || echo 0"]
            stdout: SplitParser {
                onRead: data => {
                    if (!data) return
                    var val = parseInt(data.trim());
                    gpuText.text = (isNaN(val) ? "--" : val) + "%";
                }
            }
        }

        Timer {
            interval: 2000
            running: true
            repeat: true
            triggeredOnStart: true
            onTriggered: gpuProc.running = true
        }
    }
}
