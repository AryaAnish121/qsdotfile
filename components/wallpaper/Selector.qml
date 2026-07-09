import QtQuick
import Quickshell.Widgets
import qs.modules.common

Rectangle {
    property alias view: view
    property var wallpaperFolderModel
    property int currentPick

    signal hover(int index)
    signal pick()

    width: parent.width
    height: 430
    color: "transparent"

    GridView {
        id: view

        readonly property int columns: 4

        width: cellWidth * columns
        height: parent.height - 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        model: wallpaperFolderModel
        cellWidth: Math.floor((parent.width - 28) / columns)
        cellHeight: 120
        clip: true

        delegate: Item {
            height: view.cellHeight
            width: view.cellWidth

            Rectangle {
                height: parent.height - 10
                width: parent.width - 6
                anchors.centerIn: parent
                color: "transparent"
                radius: 6

                border {
                    width: (index == currentPick) ? 3 : 0
                    color: Colors.overPrimaryFixedVariant
                }

                ClippingRectangle {
                    anchors.fill: parent
                    radius: 4
                    anchors.margins: (index == currentPick) ? 10 : 8

                    Image {
                        anchors.fill: parent
                        source: wallpaperFolderModel.get(index, "fileUrl") || ""
                        fillMode: Image.PreserveAspectCrop
                        asynchronous: true
                    }

                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onEntered: {
                        hover(index);
                    }
                    onClicked: {
                        pick();
                    }
                }

            }

        }

    }

}
