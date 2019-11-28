import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import gesture 1.0
import "./ui/game"

Item {
    id: game_main
    visible: true
    width: Screen.width
    height: Screen.height

    property variant song_data: null
    property int global_offset: 0

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.BlankCursor
        enabled: false
    }

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
        asynchronous: true
    }

    Image {
        property int time: 1000

        id: game_transition
        source: "qrc:/ui/home/game-transition.png"
        anchors.verticalCenter: parent.verticalCenter
        visible: true
        width: pageloader.width
        height: pageloader.height
        fillMode: Image.PreserveAspectFit
        asynchronous: true

        x: parent.width

        Behavior on x {
            NumberAnimation {
                duration: game_transition.time
                easing.type: Easing.OutExpo
            }
        }

        states: [
            State {
                name: "LOADING"
                PropertyChanges {
                    target: game_transition
                    x: 0
                }
            },
            State {
                name: "COMPLETE"
                PropertyChanges {
                    target: game_transition
                    x: parent.width
                }
            }
        ]
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

    Component.onCompleted: {

    }

    Component.onDestruction: {
    }
}
