import QtQuick
import Quickshell
import Quickshell.Io

Row {
    id: root
    spacing: 8

    property real cpuTemp: 0
    property real gpuTemp: 0

    // CPU Process: Isolates the k10temp block and extracts Tctl (Fastfetch standard)
    Process {
        id: cpuProc
        command: ["sh", "-c", "sensors -u | awk '/k10temp/{flag=1; next} /^$/{flag=0} flag && /temp1_input/{print $2; exit}'"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: root.cpuTemp = parseFloat(this.text)
        }
    }

    // GPU Process: Maps the actual amdgpu hardware monitor edge sensor 
    Process {
        id: gpuProc
        command: ["sh", "-c", "cat /sys/class/drm/card*/device/hwmon/hwmon*/temp1_input | head -n 1"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: root.gpuTemp = parseFloat(this.text) / 1000
        }
    }

    // Timer Loop: Ensures clean stop-and-restart execution every 2 seconds
    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            cpuProc.running = false
            gpuProc.running = false
            
            cpuProc.running = true
            gpuProc.running = true
        }
    }

    Text {
	    text: "CPU: " + root.cpuTemp.toFixed(0) + "°C"
        color: root.cpuTemp > 80 ? "#e06c75" : "#ebdbb2"
        font.family: "JetBrainsMono Nerd Font"
    }

    Text {
	    text: "GPU: " + root.gpuTemp.toFixed(0) + "°C"
        color: root.gpuTemp > 80 ? "#e06c75" : "#ebdbb2"
        font.family: "JetBrainsMono Nerd Font"
    }
}

