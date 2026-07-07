import Qt.labs.folderlistmodel
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets

PanelWindow {
    id: mainWindow

    property bool pickerActivated: false
    property int currentPick: 6

    function selection() {
        searchBar.text = "";
        mainWindow.pickerActivated = false;
        const wallpaper = wallpaperFolderModel.get(currentPick, "fileName");
        const wallpaperPath = `/home/arya/wallpapers/wallpapers/${wallpaper}`;
        if (wallpaper)
            changeWallpaper(wallpaperPath);

    }

    function changeWallpaper(wallpaperPath) {
        wallpaperChangeProcess.command = ["bash", Quickshell.shellPath("scripts/wallpaper_switcher.sh"), wallpaperPath];
        wallpaperChangeProcess.running = true;
    }

    implicitWidth: 780
    implicitHeight: mainContent.height
    visible: pickerActivated
    color: "transparent"
    focusable: true

    Process {
        id: wallpaperChangeProcess

        running: false

        stdout: StdioCollector {
            onStreamFinished: console.log(`line read: ${this.text}`)
        }

    }

    HyprlandFocusGrab {
        active: pickerActivated
        windows: [mainWindow]
    }

    GlobalShortcut {
        name: "wallpaper"
        onPressed: {
            mainWindow.pickerActivated = !mainWindow.pickerActivated;
        }
    }

    FolderListModel {
        id: wallpaperFolderModel

        caseSensitive: false
        nameFilters: searchBar.text == "" ? ["*"] : ["*" + searchBar.text + "*"]
        folder: "file:///home/arya/.krypton/thumbnails"
    }

    Rectangle {
        height: parent.height
        width: parent.width
        color: "#111418"
        radius: 8

        border {
            color: "#43474e"
            width: 1
        }

        Column {
            id: mainContent

            width: parent.width

            Rectangle {
                width: parent.width
                height: 75
                color: "transparent"
                radius: 8

                Rectangle {
                    height: 1
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    color: "#43474e"
                }

                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: 25
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 50

                    Text {
                        font.family: "Phosphor-Bold"
                        text: ""
                        font.pixelSize: 22
                        color: '#305f8b'
                    }

                    Text {
                        color: '#e0e0e0'
                        font.weight: 500
                        font.pixelSize: 14
                        font.family: "JetBrains Mono"
                        text: "search..."
                        visible: searchBar.text == ""

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.IBeamCursor
                        }

                    }

                    TextInput {
                        id: searchBar

                        text: ""
                        color: "#e0e0e0"
                        font.weight: 500
                        font.pixelSize: 14
                        font.family: "JetBrains Mono"
                        anchors.verticalCenter: parent.verticalCenter
                        focus: pickerActivated
                        Keys.onPressed: (event) => {
                            let maxIndex = wallpaperFolderModel.count - 1;
                            let cols = view.columns;
                            if (event.key == Qt.Key_Left) {
                                mainWindow.currentPick = Math.max(0, mainWindow.currentPick - 1);
                                view.positionViewAtIndex(currentPick, GridView.Contain);
                                event.accepted = true;
                            } else if (event.key == Qt.Key_Right) {
                                mainWindow.currentPick = Math.min(maxIndex, mainWindow.currentPick + 1);
                                view.positionViewAtIndex(currentPick, GridView.Contain);
                                event.accepted = true;
                            } else if (event.key === Qt.Key_Up) {
                                mainWindow.currentPick = Math.max(0, mainWindow.currentPick - cols);
                                event.accepted = true;
                                view.positionViewAtIndex(currentPick, GridView.Contain);
                            } else if (event.key === Qt.Key_Down) {
                                mainWindow.currentPick = Math.min(maxIndex, mainWindow.currentPick + cols);
                                view.positionViewAtIndex(currentPick, GridView.Contain);
                                event.accepted = true;
                            } else if (event.key == Qt.Key_Return) {
                                selection();
                                event.accepted = true;
                            } else if (event.key == Qt.Key_Escape) {
                                searchBar.text = "";
                                mainWindow.pickerActivated = false;
                                event.accepted = true;
                            }
                        }

                        HoverHandler {
                            cursorShape: Qt.IBeamCursor
                        }

                    }

                }

            }

            Rectangle {
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

                    delegate: Rectangle {
                        height: view.cellHeight
                        width: view.cellWidth
                        color: "transparent"

                        Rectangle {
                            height: parent.height - 10
                            width: parent.width - 6
                            anchors.centerIn: parent
                            color: "transparent"
                            radius: 6

                            border {
                                width: (index == currentPick) ? 2 : 0
                                color: '#1d5e9b'
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
                                    mainWindow.currentPick = index;
                                }
                                onClicked: {
                                    selection();
                                }
                            }

                        }

                    }

                }

            }

        }

    }

}
