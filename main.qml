import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

import "./ui/game"

ApplicationWindow {
    visible: true
    visibility: Window.FullScreen
    //width: 1366
    //height: 768

    color: "#000000"

    title: "NeoHand 2nd Generation: SEED OF LEGGENDARIA"

    Loader {
        id: pageloader
        height: parent.height
        width: height * 16/9
        anchors {
            centerIn: parent
        }
        focus: true
        source: "/ui/songselect/Songselect.qml" //"/ui/option/mainPanel.qml"

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
}
