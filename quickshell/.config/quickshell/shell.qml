//@ pragma UseQApplication

import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray

import QtQuick

ShellRoot {
    id: root

    signal updateLayout
    signal updateSubmap(string data)

    Variants {
        id: variants

        readonly property string primaryScreenName: {
            let largestScreenName = "";
            let largestScreenSize = 0;
            for (let i = 0; i < model.length; ++i) {
                const screen = model[i];
                const size = screen.width * screen.height;
                if (size > largestScreenSize) {
                    largestScreenSize = size;
                    largestScreenName = screen.name;
                }
            }
            return largestScreenName;
        }

        model: Quickshell.screens

        PanelWindow {
            id: panelWindow

            required property ShellScreen modelData
            readonly property bool isPrimaryScreen:
                screen.name === variants.primaryScreenName

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
                id: leftModules

                anchors.left: parent.left
                anchors.leftMargin: 10
                height: parent.height
                spacing: 10

                Workspaces {
                    height: parent.height
                }

                Separator {
                    visible: submap.visible
                }

                Submap {
                    id: submap

                    Connections {
                        target: root

                        function onUpdateSubmap(data) {
                            submap.updateSubmap(data);
                        }
                    }
                }
            }

            Row {
                id: rightModules

                anchors.right: parent.right
                anchors.rightMargin: 10
                height: parent.height
                visible: isPrimaryScreen
                spacing: 10

                KeyboardLayout {
                    id: keyboardLayout

                    height: parent.height

                    Connections {
                        target: root

                        function onUpdateLayout() {
                            keyboardLayout.updateLayout();
                        }
                    }
                }

                Separator {}

                Volume {
                    height: parent.height
                }

                Separator {}

                CpuUsage {
                    id: cpuUsage

                    Connections {
                        target: timer
                        function onTriggered() { cpuUsage.setRunning(); }
                    }
                }

                Separator {}

                MemoryUsage {
                    id: memoryUsage

                    Connections {
                        target: timer
                        function onTriggered() { memoryUsage.setRunning(); }
                    }
                }

                Separator {}

                DiskUsage {
                    id: diskUsage

                    Connections {
                        target: timer
                        function onTriggered() { diskUsage.setRunning(); }
                    }
                }

                Separator {}

                Clock {}

                Separator {}

                Tray {
                    height: parent.height
                }
            }
        }
    }

    Connections {
        target: Hyprland

        function onRawEvent(event) {
            if (event.name === "activelayout") {
                root.updateLayout();
            } else if (event.name === "submap") {
                root.updateSubmap(event.data);
            }
        }
    }

    Timer {
        id: timer

        interval: 2000
        running: true
        repeat: true
    }
}
