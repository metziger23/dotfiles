import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Row {
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
                id: mouseArea

                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton |
                    Qt.RightButton |
                    Qt.MiddleButton
                anchors.fill: parent

                onClicked: event => {
                    if (event.button === Qt.LeftButton) {
                        modelData.activate();
                    } else if (event.button == Qt.MiddleButton) {
                        modelData.secondaryActivate();
                    } else if (event.button == Qt.RightButton) {
                        menuAnchor.open();
                    }
                }
            }

            QsMenuAnchor {
                id: menuAnchor

                menu: modelData.menu

                anchor.window: mouseArea.QsWindow.window
                anchor.adjustment: PopupAdjustment.Flip

                anchor.onAnchoring: {
                    const window = mouseArea.QsWindow.window;
                    const widgetRect = window.contentItem.mapFromItem(
                        mouseArea, 0,
                        mouseArea.height, mouseArea.width,
                        mouseArea.height);

                    menuAnchor.anchor.rect = widgetRect;
                }

            }

            Tooltip {
                relativeItem: mouseArea.containsMouse ? mouseArea : null

                StyledText {
                    color: "white"
                    text: modelData.tooltipTitle || modelData.id
                }
            }
        }
    }
}
