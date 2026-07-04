import Qt.labs.folderlistmodel
import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets

PanelWindow {
    id: root

    readonly property int padding_list: 50
    property int currentSelected: 0

    screen: Quickshell.screens[1]
    color: "transparent"
    WlrLayershell.namespace: "wallpaper"
    implicitWidth: 750
    implicitHeight: mainContent.height

    FolderListModel {
        id: folderModel

        folder: "file:///home/arya/Pictures/test"
        nameFilters: ["*.png", "*.jpg", "*.webp"]
    }

    Rectangle {
        width: parent.width
        color: "#141218"
        height: parent.height
        radius: 10

        Column {
            id: mainContent

            width: parent.width

            TextField {
                width: parent.width
                placeholderText: "Search..."
                placeholderTextColor: "#ffffff"
                font.weight: 500
                font.pixelSize: 15
                font.family: "SF Pro Text"
                color: "white"
                height: 70
                leftPadding: 50

                background: Rectangle {
                    color: "transparent"
                }

            }

            Rectangle {
                width: parent.width
                height: 2
                color: "#49454e"
            }

            Item {
                width: parent.width
                height: 500

                ScrollView {
                    width: parent.width - 40
                    height: parent.height - 40
                    anchors.centerIn: parent

                    Grid {
                        readonly property int cellWidth: (parent.width - ((columns - 1) * spacing)) / columns

                        columns: 4
                        spacing: 15

                        Repeater {
                            model: folderModel

                            Item {
                                height: 95
                                width: parent.cellWidth

                                Rectangle {
                                    anchors.fill: parent
                                    color: "transparent"
                                    radius: 5

                                    ClippingRectangle {
                                        anchors.fill: parent
                                        radius: 5
                                        anchors.margins: 8

                                        Image {
                                            asynchronous: true
                                            sourceSize.width: parent.width
                                            sourceSize.height: parent.height
                                            anchors.fill: parent
                                            source: folderModel.get(index, "filePath")
                                            fillMode: Image.PreserveAspectCrop
                                        }

                                    }

                                    border {
                                        color: '#36c3c3c3'
                                        width: (root.currentSelected == index) ? 4 : 0
                                    }

                                }

                            }

                        }

                    }

                }

            }

        }

        border {
            color: "#49454e"
            width: 2
        }

    }

}
