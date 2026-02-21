import QtQuick
import QtQuick.Controls

Text {
    id: root

    property alias underlineRectVisible: underlineRect.visible
    font.pixelSize: 14
    font.bold: true
    font.family: "Fira Code"
    verticalAlignment: Text.AlignVCenter
    color: "white"
    leftPadding: 8
    rightPadding: 8

    Rectangle {
        id: underlineRect

        anchors.bottom: parent.bottom
        height: 4
        color: root.color
        width: root.width
    }
}
