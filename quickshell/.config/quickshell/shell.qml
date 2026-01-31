import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import QtQuick

ShellRoot {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panelWindow
            property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30
            color: Colors.bg

            margins {
                top: 0
                bottom: 0
                left: 0
                right: 0
            }

            Row {
                anchors.fill: parent
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
                            readonly property bool isActive: modelData.active

                            width: childrenRect.width
                            height: childrenRect.height
                            visible: {
                                if (!panelWindow.screen || !modelData.monitor) {
                                    return false;
                                }
                                return panelWindow.screen.name === modelData.monitor.name;
                            }

                            Text {
                                color: isActive ? Colors.mauve : Colors.rosewater
                                text: modelData.name
                                font.pixelSize: 14
                                font.bold: true 
                                font.family: "Fira Code" 

                            } 
                        } 
                    }

                    
                } 

            }
        }
    }
}
