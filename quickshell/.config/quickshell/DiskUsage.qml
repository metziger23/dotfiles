import QtQuick

import Quickshell.Io

StyledText {
    property int diskUsage: 0

    height: parent.height
    text:  "disk: " + diskUsage + "%" 
    color: Colors.peach

    function setRunning() {
        process.running = true
    } 

    Process {
        id: process
        command: ["sh", "-c", "df / | tail -1"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var parts = data.trim().split(/\s+/)
                var percentStr = parts[4] || "0%"
                diskUsage = parseInt(percentStr.replace('%', '')) || 0
            }
        }
        Component.onCompleted: running = true
    }
}
