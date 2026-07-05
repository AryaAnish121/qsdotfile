import QtQuick
import qs.modules.dock.main

Row {
    property int ypadding

    spacing: 12
    height: parent.height - ypadding
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter

    Row {
        height: parent.height
        spacing: 5

        Repeater {
            model: Applist.apps.pinnedApps

            DockApp {
                appData: modelData
            }

        }

    }

    Separator {
        visible: Applist.apps.pinnedApps.length != 0
    }

    Row {
        height: parent.height
        spacing: 5

        Repeater {
            model: Applist.apps.unPinnedApps

            DockApp {
                appData: modelData
            }

        }

    }

    Separator {
        visible: Applist.apps.unPinnedApps.length != 0
    }

    MusicPlayer {
        dockItems: Applist.apps.pinnedApps.length + Applist.apps.unPinnedApps
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 400
            easing.type: Easing.InOutQuad
        }

    }

}
