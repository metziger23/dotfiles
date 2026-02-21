import QtQuick

import Quickshell
import Quickshell.Io

StyledText {
    readonly property string defaultActiveBorderColor:
        "\"rgba(33ccffee) rgba(00ff99ee) 45deg\""

    readonly property string resizeActiveBorderColor:
        "\"rgba(ff0000ee) rgba(ff4500ee) 45deg\""

    height: parent.height
    visible: text !== ""
    color: Colors.red

    function updateSubmap(data) {
        const activeBorderColor = data === "resize" 
            ? resizeActiveBorderColor 
            : defaultActiveBorderColor

        if (data === "") {
            text = data;
        } else {
            text = "submap: " + data;
        }

        Quickshell.execDetached(["hyprctl", "keyword",
            "general:col.active_border",
            activeBorderColor
        ])
    }
}
