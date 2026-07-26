import QtQuick

import Quickshell
import Quickshell.Io

StyledText {
    readonly property string format: "HH:mm - ddd, MMM dd"
    height: parent.height
    color: Colors.sapphire
    text: Qt.formatDateTime(new Date(), format)

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: text = Qt.formatDateTime(new Date(), format)
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            Quickshell.execDetached(["kitty", "calcurse"]);
        }
    }
}
