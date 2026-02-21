//@ pragma UseQApplication

import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray

import QtQuick

Row {
    spacing: 10

    Repeater {
        model: SortFilterModel {

            property var names: Object.freeze([
                "A", "R", "S", "T", "G", "Q", "W", "F", "P", "B",
                "J", "L", "U", "Y", "M", "Z", "X", "C", "D", "V", "K", "H"
            ])

            lessThan: function(left, right) {
                const leftIndex = names.indexOf(left.modelData.name);
                const rightIndex = names.indexOf(right.modelData.name);

                if (leftIndex !== -1 && rightIndex !== -1) {
                    return leftIndex < rightIndex;
                }

                return true;
            }

            model: Hyprland.workspaces

            delegate: Item {
                width: 20
                height: parent.height
                visible: {
                    if (!panelWindow.screen || !modelData.monitor) {
                        return false;
                    }
                    return panelWindow.screen.name === modelData.monitor.name;
                }

                StyledText {
                    height: parent.height
                    color: {
                        if (modelData.active) {
                            return Colors.mauve;
                        }
                        if (modelData.urgent) {
                            return Colors.red;
                        }
                        return Colors.rosewater;
                    }
                    text: modelData.name
                    style: mouseArea.containsMouse ? Text.Sunken : Text.Normal
                    styleColor: color
                    underlineRectVisible: modelData.active 
                        || modelData.urgent || mouseArea.containsMouse
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent

                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onClicked: {
                        Hyprland.dispatch(`workspace ${modelData.name}`);
                    }
                }
            }
        }
    }
}
