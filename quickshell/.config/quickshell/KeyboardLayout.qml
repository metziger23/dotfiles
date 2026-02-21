import Quickshell
import Quickshell.Hyprland

import QtQuick

StyledText {
    id: root

    property string currentLayout: ""
    property string hyprlandKeyboard: ""

    color: Colors.blue
    text: {
        if (currentLayout === "us_metziger") {
            return "us";
        } else if (currentLayout === "ru_metziger") {
            return "ru";
        }
        return "";
    }

    function updateLayout() {
        Proc.runCommand(null, ["hyprctl", "-j", "devices"], (output, exitCode) => {
            if (exitCode !== 0) {
                root.currentLayout = "Unknown";
                return;
            }

            try {
                const data = JSON.parse(output);
                const mainKeyboard = data.keyboards.find(kb => kb.main === true);
                root.hyprlandKeyboard = mainKeyboard.name;

                if (!mainKeyboard) {
                    root.currentLayout = "Unknown";
                    return;
                }

                const layout = mainKeyboard.layout;
                const variant = mainKeyboard.variant;
                const index = mainKeyboard.active_layout_index;

                if (layout && index !== undefined) {
                    const layouts = mainKeyboard.layout.split(",");
                    const variants = mainKeyboard.variant.split(",");
                    const index = mainKeyboard.active_layout_index;

                    if (layouts[index] && variants[index] !== undefined) {
                        if (variants[index] === "") {
                            root.currentLayout = layouts[index];
                        } else {
                            root.currentLayout = layouts[index] + "-" + variants[index];
                        }
                    } else {
                        root.currentLayout = layouts[index];
                    }
                } else if (mainKeyboard && mainKeyboard.active_keymap) {
                    root.currentLayout = mainKeyboard.active_keymap;
                } else {
                    root.currentLayout = "Unknown";
                }

            } catch (e) {
                root.currentLayout = "Unknown";
            }
        });
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            Quickshell.execDetached(["hyprctl", "switchxkblayout", root.hyprlandKeyboard, "next"]);
        }
    }

    Component.onCompleted: {
        updateLayout();
    }
}
