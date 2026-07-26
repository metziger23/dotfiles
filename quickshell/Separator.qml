import QtQuick
import QtQuick.Controls

Item {
    id: root

    width: 5
    height: parent.height
    
    Rectangle {
        anchors {
            topMargin: 8
            bottomMargin: 8
            top: parent.top
            bottom: parent.bottom
            horizontalCenter: root.horizontalCenter
        }
        width: root.width / 2
        color: Colors.surface
    }
}


