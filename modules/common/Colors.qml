// credit: ambxst

import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

FileView {
    property color background: adapter.background
    property color dockBackground: Qt.rgba(background.r, background.g, background.b, 0.3)
    property color dockOption: Qt.rgba(surfaceContainerLowest.r, surfaceContainerLowest.g, surfaceContainerLowest.b, 0.4)
    property color surfaceContainerLowest: adapter.surfaceContainerLowest
    property color overBackground: adapter.overBackground
    property color surfaceVariant: adapter.surfaceVariant
    property color primary: adapter.primary
    property color overPrimaryFixedVariant: adapter.overPrimaryFixedVariant

    path: `${Quickshell.env("HOME")}/.krypton/colors.json`
    blockLoading: true
    watchChanges: true
    onFileChanged: {
        reload();
    }

    adapter: JsonAdapter {
        property color background: "#1a1111"
        property color surfaceContainerLowest: "#140c0c"
        property color overBackground: "#f1dedd"
        property color surfaceVariant: "#534342"
        property color primary: "#ffb3ae"
        property color overPrimaryFixedVariant: "#733331"
    }

}
