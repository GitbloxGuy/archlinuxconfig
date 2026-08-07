import QtQuick
import Quickshell.Services.Pipewire

Text {
    color: "#ebdbb2"
    font.family: "JetBrainsMono Nerd Font"
    font.pixelSize: 13

    // Keeps Pipewire.defaultAudioSink's properties (volume, muted) live-updated
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

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
