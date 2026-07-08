import Qt.labs.folderlistmodel
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import qs.components.wallpaper

PanelWindow {
    id: mainWindow

    property bool pickerActivated: false
    property int currentPick: 6

    function selection() {
        search.searchBar.text = "";
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
        nameFilters: search.searchBar.text == "" ? ["*"] : ["*" + search.searchBar.text + "*"]
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

            SearchBar {
                id: search

                pickerActivated: mainWindow.pickerActivated
                currentPick: mainWindow.currentPick
                wallpaperCount: wallpaperFolderModel.count
                view: selector.view
                onSetCurrentPick: (pick) => {
                    mainWindow.currentPick = pick;
                }
                onClosePicker: () => {
                    mainWindow.pickerActivated = false;
                }
            }

            Selector {
                id: selector

                wallpaperFolderModel: wallpaperFolderModel
                currentPick: mainWindow.currentPick
                onHover: (index) => {
                    mainWindow.currentPick = index;
                }
                onPick: {
                    mainWindow.selection();
                }
            }

        }

    }

}
