import QtQuick
import Quickshell.Services.UPower

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
