import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.components.dock.main
import qs.components.dock.selector
import qs.components.dock.sound
import qs.modules.dock.main

PanelWindow {
    // logout needs fix; not working for me for some reason

    id: root

    readonly property int xpadding_dock: 20
    readonly property int ypadding_dock: 15
    readonly property var width_mode: {
        "audio": 325,
        "dock": dock.width + root.xpadding_dock,
        "screenshot": screenshot.width + root.xpadding_dock,
        "powerMenu": powerMenu.width + root.xpadding_dock
    }
    readonly property var powerMenuOptions: [{
        "icon": "",
        "command": ["sh", "-c", "loginctl lock-session"]
    }, {
        "icon": "",
        "command": ["sh", "-c", "systemctl suspend"]
    }, {
        "icon": "",
        "command": ["sh", "-c", "loginctl terminate-session self"]
    }, {
        "icon": "",
        "command": ["sh", "-c", "systemctl reboot"]
    }, {
        "icon": "",
        "command": ["sh", "-c", "systemctl poweroff"]
    }]
    readonly property var screenshotOptions: [{
        "icon": "",
        "command": ["rishot"]
    }, {
        "icon": "",
        "command": ["bash", Quickshell.shellPath("scripts/ocr.sh")]
    }, {
        "icon": "",
        "command": ["bash", Quickshell.shellPath("scripts/lens.sh")]
    }, {
        "icon": "",
        "command": ["bash", Quickshell.shellPath("scripts/picker.sh")]
    }]
    property string mode: "dock"

    function switchMode(switchTo) {
        if (switchTo != "audio")
            root.mode = root.mode == switchTo ? "dock" : switchTo;
        else
            root.mode = "audio";
    }

    function closeDockMain() {
        root.mode = "dock";
    }

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
        width: width_mode[mode]
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 2
        anchors.bottomMargin: 8

        DockContent {
            id: dock

            visible: mode == "dock"
            opacity: mode == "dock" ? 1 : 0
            ypadding: root.ypadding_dock
        }

        SoundContent {
            visible: (mode == "audio")
            opacity: (mode == "audio") ? 1 : 0
            onDockChange: {
                switchMode("audio");
            }
            onDockClose: {
                closeDockMain();
            }
        }

        ListSelector {
            id: powerMenu

            selectorId: "powerMenu"
            mode: root.mode
            mainWindow: root
            ypadding: root.ypadding_dock
            options: root.powerMenuOptions
            onDockClose: {
                closeDockMain();
            }
            onToggleDock: {
                switchMode("powerMenu");
            }
        }

        ListSelector {
            id: screenshot

            selectorId: "screenshot"
            mode: root.mode
            mainWindow: root
            ypadding: root.ypadding_dock
            options: root.screenshotOptions
            onDockClose: {
                closeDockMain();
            }
            onToggleDock: {
                switchMode("screenshot");
            }
        }

        border {
            color: '#1ac3c3c3'
            width: 1
        }

        Behavior on width {
            NumberAnimation {
                duration: 100
                easing.type: Easing.InOutQuad
            }

        }

    }

}
