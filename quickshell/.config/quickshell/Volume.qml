import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io

import QtQuick
import QtQuick.Controls

StyledText {
    id: root

    property var sink: Pipewire.defaultAudioSink

    color: Colors.yellow
    text: {
        if (sink?.audio) {
            return "vol: " + (sink.audio.muted ?
                "muted" : `${Math.round(sink.audio.volume * 100)}%`)
        }

        return "";
    }

    PwObjectTracker { 
        objects: [Pipewire.defaultAudioSink]
        onObjectsChanged: {
            sink = Pipewire.defaultAudioSink
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            if (sink?.audio) {
                sink.audio.muted = !sink.audio.muted
            }
        }

        onWheel: function(event) {
            if (sink?.audio) {
                sink.audio.volume = Math.max(0, 
                    Math.min(1, sink.audio.volume + (event.angleDelta.y / 120) * 0.05))
            }
        }
    }
}
