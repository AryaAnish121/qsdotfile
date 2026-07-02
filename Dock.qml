import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Wayland
import qs.components.dock.main
import qs.modules.bar

PanelWindow {
    id: root

    readonly property int xpadding_dock: 20
    readonly property int ypadding_dock: 15
    property bool showVolume: false

    screen: Quickshell.screens[0]
    implicitHeight: 73
    color: "transparent"
    WlrLayershell.namespace: "qsdock"

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    property real systemVolume: Pipewire.defaultAudioSink?.audio.volume ?? 0.0

    anchors {
        bottom: true
        left: true
        right: true
    }

    Timer {
        id: volumeTimer
        interval: 700
        onTriggered: {
            root.showVolume = false
        }
    }

    onSystemVolumeChanged: {
        root.showVolume = true
        volumeTimer.restart()
    }

    Rectangle {
        id: meow
        color: '#21000000'
        radius: 10
        width: {
            if (showVolume)
                return 325;

            return dock.width + root.xpadding_dock;
        }
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 2
        anchors.bottomMargin: 8

        Behavior on width {
            NumberAnimation {
                duration: 100
                easing.type: Easing.InOutQuad
            }
        }

        DockContent {
            id: dock

            visible: !showVolume
            opacity: !showVolume ? 1 : 0


            Behavior on opacity {
                NumberAnimation {
                    duration: 400
                    easing.type: Easing.InOutQuad
                }
            }
        }

        Item {
            visible: showVolume
            height: parent.height
            width: parent.width
            opacity: !showVolume ? 0 : 1


            Behavior on opacity {
                NumberAnimation {
                    duration: 400
                    easing.type: Easing.InOutQuad
                }
            }

            Row {
                spacing: 22
                anchors.centerIn: parent

                ShellText {
                    text: "󰕾"
                    font.pixelSize: 22
                    color: '#E9DEF8'
                }

                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    radius: 5
                    height: 5
                    width: 200
                    color: "#4E3D75"

                    Rectangle {
                        height: parent.height
                        width: systemVolume * parent.width
                        radius: 5
                        color: "#E9DEF8"
                    }

                }

            }

        }

        border {
            color: '#1ac3c3c3'
            width: 1
        }

    }

}
