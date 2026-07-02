import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Wayland
import qs.components.dock.main
import qs.modules.common
import qs.components.dock.sound

PanelWindow {
    id: root

    readonly property int xpadding_dock: 20
    readonly property int ypadding_dock: 15
    readonly property var width_mode: {
        "audio": 325
    }

    property string mode: "dock"

    screen: Quickshell.screens[0]
    implicitHeight: 73
    color: "transparent"
    WlrLayershell.namespace: "qsdock"

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    property real systemVolume: Pipewire.defaultAudioSink?.audio.volume ?? 0.0
    property bool systemVolumeMuted: Pipewire.defaultAudioSink?.audio.muted ?? true

    anchors {
        bottom: true
        left: true
        right: true
    }

    Timer {
        id: volumeTimer
        interval: 1000
        onTriggered: {
            root.mode = "dock"
        }
    }

    onSystemVolumeChanged: {
        root.mode = "audio"
        volumeTimer.restart()
    }

    Rectangle {
        id: meow
        color: '#21000000'
        radius: 10
        width: {
            if (mode != "dock")
                return width_mode[mode];

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

            visible: mode == "dock"
            opacity: mode == "dock" ? 1 : 0
        }


        SoundContent{
            visible: (mode == "audio")
            opacity: (mode == "audio") ? 1 : 0

            volume: systemVolume
            muted: systemVolumeMuted
        }

        border {
            color: '#1ac3c3c3'
            width: 1
        }

    }

}
