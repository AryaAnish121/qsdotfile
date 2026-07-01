import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.components.dock.main
import qs.modules.dock.main

PanelWindow {
    id: root

    readonly property int xpadding_dock: 20
    readonly property int ypadding_dock: 15

    screen: Quickshell.screens[0]
    implicitHeight: 73
    color: "transparent"
    WlrLayershell.namespace: "qsdock"

    anchors {
        bottom: true
        left: true
        right: true
    }

    Rectangle {
        color: '#21000000'
        radius: 10
        width: dock.width + root.xpadding_dock
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 2
        anchors.bottomMargin: 8

        Row {
            id: dock

            spacing: 12
            height: parent.height - root.ypadding_dock
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Row {
                height: parent.height
                spacing: 8

                DockApps {
                }

            }

            Rectangle {
                width: 2
                color: '#a4808080'
                height: parent.height * 0.3
                anchors.verticalCenter: parent.verticalCenter
                radius: 5
            }

            MusicPlayer {
            }

        }

        border {
            color: '#1ac3c3c3'
            width: 1
        }

    }

}
