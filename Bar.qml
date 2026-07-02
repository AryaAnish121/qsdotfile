import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.components.bar
import qs.modules.common

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData
            implicitHeight: 37
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            Rectangle {
                anchors.fill: parent

                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 10
                    anchors.leftMargin: 18
                    anchors.left: parent.left

                    ShellText {
                        text: "󰜡"
                    }

                    ShellText {
                        font.bold: true
                        text: {
                            const win = Hyprland.activeToplevel;
                            if (!win || !win.wayland)
                                return "";

                            const entry = DesktopEntries.byId(win.wayland.appId);
                            return entry ? entry.name : win.title;
                        }
                    }

                }

                Row {
                    spacing: 17
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 18

                    SystemTray {
                    }

                    ClockWidget {
                    }

                }

                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: '#5a000000'
                    }

                    GradientStop {
                        position: 1
                        color: '#00000000'
                    }

                }

            }

        }

    }

}
