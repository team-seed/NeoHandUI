import QtQuick 2.0

Item {
    anchors.fill: parent

    Image {
        id: mainlogo
        source: "qrc:/images/mainlogo.png"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        opacity: 0

        Text {
            id: press_start
            text: "PRESS  ENTER"
            color: "white"
            font.family: font_hemi_head.name
            font.pixelSize: 60
            style: Text.Outline
            styleColor: "black"
            visible: false

            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: parent.height / 8
            }

            SequentialAnimation on opacity {
                loops: Animation.Infinite
                running: true
                NumberAnimation {
                    duration: 500; from: 1; to: 0; easing.type: Easing.InExpo
                }
                NumberAnimation {
                    duration: 500; from: 0; to: 1; easing.type: Easing.OutExpo
                }
            }
        }
    }

    Rectangle {
        id: whitebg
        color: "white"
        anchors.fill: parent
        opacity: 0

        Image {
            id: teamlogo
            source: "qrc:/images/TSlogo.png"
            anchors.centerIn: parent
            height: parent.height / 2
            width: height
            fillMode: Image.PreserveAspectFit
            opacity: 0
        }

        Image {
            id: mediapipelogo
            source: "qrc:/images/mediapipelogo.png"
            anchors.centerIn: parent
            height: parent.height / 2
            width: height
            fillMode: Image.PreserveAspectFit
            opacity: 0
        }

        Image {
            id: qtlogo
            source: "qrc:/images/Qtlogo.png"
            anchors.centerIn: parent
            height: parent.height / 2
            width: height
            fillMode: Image.PreserveAspectFit
            opacity: 0
        }
    }

    SequentialAnimation {
        loops: Animation.Infinite
        running: true


        PauseAnimation {
            duration: 2000
        }
        PropertyAnimation { target: whitebg; property: "opacity"
            from: 0; to: 1; duration: 1000
        }

        PropertyAnimation { target: teamlogo; property: "opacity"
            from: 0; to: 1; duration: 1000
        }
        PauseAnimation { duration: 1000 }
        PropertyAnimation { target: teamlogo; property: "opacity"
            from: 1; to: 0; duration: 1000
        }

        PropertyAnimation { target: mediapipelogo; property: "opacity"
            from: 0; to: 1; duration: 1000
        }
        PauseAnimation { duration: 1000 }
        PropertyAnimation { target: mediapipelogo; property: "opacity"
            from: 1; to: 0; duration: 1000
        }

        PropertyAnimation { target: qtlogo; property: "opacity"
            from: 0; to: 1; duration: 1000
        }
        PauseAnimation { duration: 1000 }
        PropertyAnimation { target: qtlogo; property: "opacity"
            from: 1; to: 0; duration: 1000
        }

        PauseAnimation { duration: 1000 }
        PropertyAnimation { target: mainlogo; property: "opacity"
            from: 0; to: 1; duration: 0
        }

        PropertyAnimation { target: whitebg; property: "opacity"
            from: 1; to: 0; duration: 1000; easing.type: Easing.InExpo
        }

        PropertyAction { target: press_start; property: "visible"; value: true }

        PauseAnimation { duration: 30000 }

        PropertyAction { target: press_start; property: "visible"; value: false }

        PropertyAnimation { target: mainlogo; property: "opacity"
            from: 1; to: 0; duration: 3000
        }
    }

    function start_game() {
        disconnect_all()
        game_transition.state = "LOADING"
        destruct.start()
    }

    function to_main () {
        pageloader.source = "/ui/option/mainPanel.qml"
    }

    function disconnect_all() {
        game_main.escpress_signal.disconnect(to_main)
        game_main.enterpress_signal.disconnect(start_game)
    }

    Component.onCompleted: {
        game_main.escpress_signal.connect(to_main)
        game_main.enterpress_signal.connect(start_game)

        game_transition.state = "COMPLETE"
    }

    Component.onDestruction: {
        disconnect_all()
    }

    Timer {
        id: destruct
        interval: game_transition.time
        onTriggered: pageloader.source = "/ui/songselect/Songselect.qml"
    }

    FontLoader {
        id: font_hemi_head
        source: "/font/hemi-head-bd-it.ttf"
    }
}
