import QtQuick

import Quickshell.Io

StyledText {
    property int memUsage: 0

    height: parent.height
    text:  "memory: " + memUsage + "%" 
    color: Colors.mauve

    function setRunning() {
        process.running = true
    } 

    Process {
        id: process
        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var parts = data.trim().split(/\s+/)
                var total = parseInt(parts[1]) || 1
                var used = parseInt(parts[2]) || 0
                memUsage = Math.round(100 * used / total)
            }
        }
        Component.onCompleted: running = true
    }
}
