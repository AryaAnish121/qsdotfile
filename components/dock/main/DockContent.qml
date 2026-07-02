import QtQuick
import qs.modules.dock.main

Row {
    spacing: 12
    height: parent.height - root.ypadding_dock
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter

    Row {
        height: parent.height
        spacing: 5

        Repeater {
            model: Applist.pinnedAppsFiltered

            DockApp {
                appData: modelData
            }

        }

    }

    Seperator {
        visible: Applist.pinnedAppsFiltered.length != 0
    }

    Row {
        height: parent.height
        spacing: 5

        Repeater {
            model: Applist.unPinnedAppsFiltered

            DockApp {
                appData: modelData
            }

        }

    }

    Seperator {
        visible: Applist.unPinnedAppsFiltered.length != 0
    }

    MusicPlayer {
        dockItems: Applist.pinnedAppsFiltered.length + Applist.unPinnedAppsFiltered
    }

}
