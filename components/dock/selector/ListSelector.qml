import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.modules.common

Row {
    id: contents

    property string mode
    property PanelWindow mainWindow
    property string selectorId
    property int ypadding
    property int currentFocused: 0
    property var options

    signal dockClose()
    signal toggleDock()

    function selection(command) {
        RunCommand.run(command);
        dockClose();
    }

    visible: (mode == selectorId)
    opacity: (mode == selectorId) ? 1 : 0
    spacing: 12
    height: parent.height - ypadding
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    focus: mode == selectorId
    Keys.onPressed: (event) => {
        if (event.key == Qt.Key_Right) {
            if (contents.currentFocused != options.length - 1)
                contents.currentFocused++;
            else
                contents.currentFocused = 0;
        }
        if (event.key == Qt.Key_Left) {
            if (contents.currentFocused != 0)
                contents.currentFocused--;
            else
                contents.currentFocused = options.length - 1;
        }
        if (event.key == Qt.Key_Return)
            selection(options[contents.currentFocused].command);

        if (event.key == Qt.Key_Escape)
            dockClose();

    }

    HyprlandFocusGrab {
        active: mode == selectorId
        windows: [mainWindow]
    }

    GlobalShortcut {
        name: selectorId
        onPressed: {
            toggleDock();
        }
    }

    Repeater {
        model: options

        Item {
            height: parent.height
            width: height
            anchors.verticalCenter: parent.verticalCenter

            Rectangle {
                anchors.fill: parent
                radius: 10
                color: (index == contents.currentFocused) ? '#220F46' : "transparent"

                Text {
                    font.family: "Phosphor-Bold"
                    anchors.centerIn: parent
                    text: modelData.icon
                    font.pixelSize: 22
                    color: '#c8aeff'
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onEntered: {
                        contents.currentFocused = index;
                    }
                    onClicked: {
                        contents.selection(options[index].command);
                    }
                }

                border {
                    color: '#1ac3c3c3'
                    width: (index == contents.currentFocused) ? 1 : 0
                }

            }

        }

    }

    Behavior on opacity {
        NumberAnimation {
            duration: 400
            easing.type: Easing.InOutQuad
        }

    }

}
