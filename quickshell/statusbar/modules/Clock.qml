import QtQuick
import Quickshell

Text {
    color: "#ebdbb2"
    font.family: "JetBrainsMono Nerd Font"
    font.pixelSize: 13

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    text: Qt.formatDateTime(clock.date, "ddd MMM d  hh:mm:ss AP")
}
