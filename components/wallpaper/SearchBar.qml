import QtQuick

Rectangle {
    property alias searchBar: searchBar
    property bool pickerActivated
    property int currentPick
    property int wallpaperCount
    property var view

    signal setCurrentPick(int pick)
    signal closePicker()

    width: parent.width
    height: 75
    color: "transparent"
    radius: 8

    Rectangle {
        height: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "#43474e"
    }

    Row {
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 25
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 50

        Text {
            font.family: "Phosphor-Bold"
            text: ""
            font.pixelSize: 22
            color: '#305f8b'
        }

        Text {
            color: '#e0e0e0'
            font.weight: 500
            font.pixelSize: 14
            font.family: "JetBrains Mono"
            text: "search..."
            visible: searchBar.text == ""

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.IBeamCursor
            }

        }

        TextInput {
            id: searchBar

            text: ""
            color: "#e0e0e0"
            font.weight: 500
            font.pixelSize: 14
            font.family: "JetBrains Mono"
            anchors.verticalCenter: parent.verticalCenter
            focus: pickerActivated
            Keys.onPressed: (event) => {
                let maxIndex = wallpaperCount - 1;
                let cols = view.columns;
                if (event.key == Qt.Key_Left) {
                    setCurrentPick(Math.max(0, currentPick - 1));
                    view.positionViewAtIndex(currentPick, GridView.Contain);
                    event.accepted = true;
                } else if (event.key == Qt.Key_Right) {
                    setCurrentPick(Math.min(maxIndex, currentPick + 1));
                    view.positionViewAtIndex(currentPick, GridView.Contain);
                    event.accepted = true;
                } else if (event.key === Qt.Key_Up) {
                    setCurrentPick(Math.max(0, currentPick - cols));
                    event.accepted = true;
                    view.positionViewAtIndex(currentPick, GridView.Contain);
                } else if (event.key === Qt.Key_Down) {
                    setCurrentPick(Math.min(maxIndex, currentPick + cols));
                    view.positionViewAtIndex(currentPick, GridView.Contain);
                    event.accepted = true;
                } else if (event.key == Qt.Key_Return) {
                    selection();
                    event.accepted = true;
                } else if (event.key == Qt.Key_Escape) {
                    searchBar.text = "";
                    closePicker();
                    event.accepted = true;
                }
            }

            HoverHandler {
                cursorShape: Qt.IBeamCursor
            }

        }

    }

}
