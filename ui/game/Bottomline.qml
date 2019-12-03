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

            Behavior on width {
                NumberAnimation {
                    easing.type: Easing.InOutExpo
                }
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

    function gain_health () {
        health.health_percentage = Math.min (1, health.health_percentage + 0.04);
    }

    function lose_health () {
        health.health_percentage = Math.max (0, health.health_percentage - 0.05);
        if (health.health_percentage <= 0) {
            game_container.gameover();
        }
    }

    FontLoader {
        id: font_hemi_head
        source: "/font/hemi-head-bd-it.ttf"
    }
}
