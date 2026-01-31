import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray

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
                anchors.left: parent.left
                anchors.leftMargin: 5
                height: parent.height
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
                            width: 10
                            height: parent.height
                            visible: {
                                if (!panelWindow.screen || !modelData.monitor) {
                                    return false;
                                }
                                return panelWindow.screen.name === modelData.monitor.name;
                            }

                            Text {
                                anchors.centerIn: parent
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
                                font.pixelSize: 14
                                font.bold: true
                                font.family: "Fira Code"
                            }
                        }
                    }


                }

            }

            Row {
                anchors.right: parent.right
                anchors.rightMargin: 5
                height: parent.height
                spacing: 10

                Repeater {
                    model: SystemTray.items

                    delegate: Image {
                        id: trayItemIcon

                        anchors.verticalCenter: parent.verticalCenter
                        width: 16
                        height: width
                        mipmap: true
                        smooth: true
                        antialiasing: true
                        source: modelData.icon;

                        MouseArea {
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            anchors.fill: parent

                            onClicked: mevent => {
                                if (mevent.button === Qt.LeftButton) {
                                    modelData.activate();
                                    return;
                                }

                                // TODO: open menu if Qt.RightButton is clicked
                            }
                        }
                    }

                }

            }
        }
    }
}
