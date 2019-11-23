import QtQuick 2.12
import QtGraphicalEffects 1.0

Item {
    id: game_bottomline

    height: parent.height / 6
    width: parent.width

    anchors {
        bottom: parent.bottom
        horizontalCenter: parent.horizontalCenter
    }

    LinearGradient {
        anchors.fill: health_bar
        source: health_bar
        gradient: Gradient {
            orientation: Gradient.Horizontal

            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 0.2; color: "orange" }
            GradientStop { position: 0.4; color: "red" }
            GradientStop { position: 0.6; color: "red" }
            GradientStop { position: 0.8; color: "orange" }
            GradientStop { position: 1.0; color: "transparent" }
        }
    }

    Rectangle {
        id: health_bar
        radius: this.height / 2
        opacity: 0.5
        color: "black"

        width: parent.width / 1.5
        height: parent.height / 4
        anchors.centerIn: parent

        border {
            width: 3
            color: "white"
        }

        Rectangle {
            id: health
            property double health_percentage: 1

            radius: this.height / 2
            color: "#DDDD88"

            width: health_percentage * (parent.width * 1 - parent.border.width * 2)
            height: parent.height - parent.border.width * 2

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
        }

        Text {
            id: health_text
            text: "NeoHand 2: SEED OF LEGGENDARIA"
            color: "#222222"

            font.pixelSize: health.height

            font.family: font_hemi_head.name
            anchors.centerIn: parent
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

            onClicked: function() {
                health.health_percentage -= 0.05
            };
        }

        Text {
            text: qsTr("DECR")
            anchors.centerIn: parent
        }
    }

    Rectangle {
        height: 50
        width: 50
        radius: 30

        color: "cyan"

        anchors {
            bottom: parent.bottom
            left: parent.left
        }

        MouseArea {
            anchors.fill: parent

            onClicked: function() {
                health.health_percentage += 0.05
            };
        }

        Text {
            text: qsTr("INCR")
            anchors.centerIn: parent
        }
    }

    FontLoader {
        id: font_hemi_head
        source: "/font/hemi-head-bd-it.ttf"
    }
}
