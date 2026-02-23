import QtQuick

import Quickshell.Io

StyledText {
    id: root

    readonly property string activeVpn: {
        if (goxrayCliProcess.vpnActive) {
            return goxrayCliProcess.name;
        } else if(openfortivpnProcess.vpnActive) {
            return openfortivpnProcess.name;
        }
        return "";
    }

    text: activeVpn === "" ? "" : "vpn: " + activeVpn

    height: parent.height
    color: Colors.pink
    visible: text !== ""

    function setRunning() {
        goxrayCliProcess.running = true
        openfortivpnProcess.running = true
    } 

    function isVpnActive(text) {
        if (!text) {
            return false;
        }
        
        return parseInt(text) > 0;
    }

    Process {
        id: goxrayCliProcess

        readonly property string name: "goxray"
        property bool vpnActive: false

        command: ["pgrep", "-c", "goxray-cli"]
        stdout: StdioCollector {
            onStreamFinished: {
                goxrayCliProcess.vpnActive = root.isVpnActive(this.text);
            }
        }
        Component.onCompleted: running = true
    }

    Process {
        id: openfortivpnProcess

        readonly property string name: "forti"
        property bool vpnActive: false

        command: ["pgrep", "-c", "openfortivpn"]
        stdout: StdioCollector {
            onStreamFinished: {
                openfortivpnProcess.vpnActive = root.isVpnActive(this.text);
            }
        }
        Component.onCompleted: running = true
    }
}
