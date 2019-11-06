import QtQuick 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.0
import "game_extension.js" as EXT

Item {
    id: game_container

    property string title: "Nacreous Snowmelt"
    property string artist: "かめりあ"
    property string jacket: "/songs/test/jacket2.png"
    property string difficulty: "BLASTER"
    property int level: 10
    property string bpm: "Various"
    property double hispeed: 2.5
    property int score: 1000000
    property int mybest: 1000000

    property double lane_length: 760 + 32 * parent.height / 1080
    property double side_length: 760 + 32 * parent.height / 1080
    property double lane_angle: 90 - 15 * parent.height / 1080
    property double side_angle: 89.875 - 12.875 * parent.height / 1080

    Combo {
        id: game_core

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Image {
        id: game_background
        anchors.fill: parent
        opacity: 0.5
        source: "./game-bg-test3.png"
        fillMode: Image.PreserveAspectCrop
    }

    Item {
        id: game_area
        antialiasing: true
        width: parent.width / 4
        height: lane_length
        anchors {
            top: game_core.bottom
            horizontalCenter: parent.horizontalCenter
        }

        Lane {
            anchors.fill: parent
        }

        transform: Rotation {
            origin.x: game_area.width / 2
            //origin.y: game_area.height / 2
            axis { x:1; y:0; z:0 } angle: lane_angle
        }
    }



    Sideleft {}

    Sideright {}

    Metadata {}

    Bottomline {}
}
