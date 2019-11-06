import QtQuick 2.0
import "game_extension.js" as EXT

Item {
    id: game_screen_side_left

    antialiasing: true
    height: parent.height / 4
    width: side_length

    anchors {
        right: game_core.left
        top: parent.top
    }

    transform: Rotation {
        origin.x: game_screen_side_left.width
        axis { x:0; y:1; z:0 } angle: side_angle
    }

    Rectangle {
        height: 50
        width: 50
        radius: 30

        color: "cyan"

        anchors {
            top: parent.top
            right: parent.right
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                EXT.generateArrow("left")
                EXT.destroyArrow(60000/135)
            }
        }

        Text {
            id: exit_button
            text: qsTr("BRST")
            anchors.centerIn: parent
        }
    }
}
