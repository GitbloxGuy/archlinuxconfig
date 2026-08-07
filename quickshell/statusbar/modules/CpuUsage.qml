import QtQuick
import Quickshell.Io

// A self-contained CPU usage indicator.
// Drop <CpuUsage /> anywhere in your bar - it renders its own Text.

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

