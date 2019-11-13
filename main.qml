import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

import "./ui/game"

Item {
    id: game_main
    visible: true
    width: Screen.width
    height: Screen.height

    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    Loader {
        id: pageloader
        height: parent.height
        width: height * 16/9
        anchors.centerIn: parent
        focus: true
        source: "/ui/option/mainPanel.qml"


    }

    Rectangle {
        height: parent.height
        color: "black"

        anchors {
            left: parent.left
            right: pageloader.left
        }
    }

    Rectangle {
        height: parent.height
        color: "black"

        anchors {
            left: pageloader.right
            right: parent.right
        }
    }

    Rectangle {
        height: 50
        width: 50
        radius: 30
        color: "cyan"
        anchors {
            top: parent.top
            left: parent.left
        }
        MouseArea {
            anchors.fill: parent
            onClicked: Qt.quit();
        }
        Text {
            id: exit_button
            text: qsTr("EXIT")
            anchors.centerIn: parent
        }
    }
    //press signal
    signal uppress_signal()
    signal downpress_signal()
    signal leftpress_signal()
    signal rightpress_signal()
    signal enterpress_signal()
    signal spacepress_signal()
    signal bksppress_signal()
    signal escpress_signal()
    //release signal
    signal uprelease_signal()
    signal downrelease_signal()
    signal leftrelease_signal()
    signal rightrelease_signal()
    signal enterrelease_signal()
    signal spacerelease_signal()
    signal bksprelease_signal()
    signal escrelease_signal()

}
