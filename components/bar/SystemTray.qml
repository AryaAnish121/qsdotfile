import QtQuick
import Quickshell
import qs.modules.bar

Row {
    spacing: 16
    anchors.verticalCenter: parent.verticalCenter

    Repeater {
        model: SystemTrayItems.items

        Item {
            id: trayItem

            width: 19
            height: 19

            QsMenuAnchor {
                id: trayMenuAnchor

                anchor.item: trayItem
                menu: modelData.menu
                anchor.edges: Edges.Bottom | Edges.Right
            }

            Image {
                anchors.fill: parent
                source: modelData.icon
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: (modelData.hasMenu) ? Qt.PointingHandCursor : Qt.ForbiddenCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: function(mouse) {
                    trayMenuAnchor.open();
                }
            }

        }

    }

}
