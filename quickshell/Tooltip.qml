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

LazyLoader {
    id: root

    // The item to display the tooltip at. If set to null the tooltip will be hidden.
    property Item relativeItem: null

    // Tracks the item after relativeItem is unset.
    property Item displayItem: null

    property var activePopup: null

    property bool hoverable: false;
    readonly property bool hovered: item?.hovered ?? false

    // The content to show in the tooltip.
    required default property Component contentDelegate

    active: displayItem != null && activePopup == this

    onRelativeItemChanged: {
        if (relativeItem == null) {
            if (item != null) item.hideTimer.start();
        } else {
            if (item != null) item.hideTimer.stop();
            displayItem = relativeItem;
            activePopup = this;
        }
    }

    PopupWindow {
        anchor {
            window: root.displayItem.QsWindow.window
            rect.y: anchor.window.height + 3
            rect.x: anchor.window.contentItem.mapFromItem(root.displayItem, root.displayItem.width / 2, 0).x
            edges: Edges.Top
            gravity: Edges.Bottom
        }

        visible: true

        property alias hovered: body.containsMouse;

        property Timer hideTimer: Timer {
            interval: 250

            // unloads the popup by causing active to become false
            onTriggered: root.activePopup = null;
        }

        color: "transparent"

        // don't accept mouse input if !hoverable
        Region { id: emptyRegion }
        mask: root.hoverable ? null : emptyRegion

        implicitWidth: body.implicitWidth
        implicitHeight: body.implicitHeight

        MouseArea {
            id: body

            anchors.fill: parent
            implicitWidth: content.implicitWidth + 40
            implicitHeight: content.implicitHeight + 20

            hoverEnabled: root.hoverable

            Rectangle {
                anchors.fill: parent

                radius: 5
                border.width: 1
                color: Colors.crust
                border.color: Colors.mantle

                Loader {
                    id: content
                    anchors.centerIn: parent
                    sourceComponent: contentDelegate
                    active: true
                }
            }
        }
    }
}
