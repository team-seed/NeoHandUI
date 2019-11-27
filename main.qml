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
    property int global_offset: 245

    Gesture { id: gesture }

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

    //hand tract signal
    //signal up_swipe()
    //signal down_swipe()
    //signal left_swipe()
    //signal right_swipe()
    //signal trigger()
    //signal untrigger()

    function trigger(){
        console.log("trigger!")
    }
    function untrigger(){
        console.log("X")
    }
    function up_swipe(){
        console.log("up")
    }
    function down_swipe(){
        console.log("down")
    }
    function left_swipe(){
        console.log("left")
    }
    function right_swipe(){
        console.log("right")
    }
    Component.onCompleted: {
        gesture.start()

        gesture.up_swipe.connect(up_swipe)
        gesture.down_swipe.connect(down_swipe)
        gesture.left_swipe.connect(left_swipe)
        gesture.right_swipe.connect(right_swipe)
        gesture.trigger.connect(trigger)
        gesture.untrigger.connect(untrigger)
    }

    Component.onDestruction: {
        gesture.up_swipe.disconnect(up_swipe)
        gesture.down_swipe.disconnect(down_swipe)
        gesture.left_swipe.disconnect(left_swipe)
        gesture.right_swipe.disconnect(right_swipe)
        gesture.trigger.disconnect(trigger)
        gesture.untrigger.disconnect(untrigger)
    }
}
