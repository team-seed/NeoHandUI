import QtQuick 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.0

import custom.game.process 1.0
import custom.game.timer 1.0

import "game_extension.js" as EXT

Item {
    id: game_container

    property int start_interval: 4000

    property string title: null
    property string artist: null
    property string jacket: null
    property string difficulty: null
    property int level: null
    property string bpm: game_process.bpm_range
    property string bg: null
    property double hispeed: 1.0
    property bool expert: null
    property int score: 0
    property int mybest: 0

    property double lane_length: 760 + 32 * parent.height / 1080
    property double side_length: 760 + 32 * parent.height / 1080
    property double lane_angle: 90 - 15 * parent.height / 1080
    property double side_angle: 89.875 - 12.875 * parent.height / 1080

    CustomGameProcess { id: game_process }

    CustomGameTimer { id: game_customtimer }

    Combo {
        id: game_core

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        z: 10
    }

    Image {
        id: game_background
        anchors.fill: parent
        opacity: 0.5
        source: bg
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
            id: game_lane_outside
            anchors.fill: parent
        }

        transform: Rotation {
            origin.x: game_area.width / 2
            axis { x:1; y:0; z:0 } angle: lane_angle
        }
    }

    Sideleft {}

    Sideright {}

    Metadata {}

    Bottomline {}

    function to_main () {
        pageloader.source = "/ui/option/mainPanel.qml"
    }

    function set_value() {
        title = game_main.song_data[2]
        artist = game_main.song_data[1]
        expert = game_main.song_data[8]
        jacket = "file:///" + game_main.song_data[0] + "/jacket.png"
        difficulty = expert ? "EXPERT" : "BASIC"
        level = expert ? game_main.song_data[7] :game_main.song_data[6]
        bg = "file:///" + game_main.song_data[0] + "/bg.png"
    }

    function increase_hispeed() {
        if (hispeed < 10) hispeed += 0.5
    }

    function decrease_hispeed() {
        if (hispeed > 0.5) hispeed -= 0.5
    }

    Component.onCompleted: {
        set_value();
        game_process.song_chart_parse((game_main.song_data[0] + (expert ? "/expert.json" : "/basic.json")));
        game_lane_outside.make_chart();
        game_customtimer.set_song("file:///" + game_main.song_data[0] + "/audio.wav");

        game_main.escpress_signal.connect(to_main)
        game_main.uppress_signal.connect(increase_hispeed)
        game_main.downpress_signal.connect(decrease_hispeed)

        game_main.spacepress_signal.connect(hit)
        game_main.enterpress_signal.connect(swipe)

        game_transition.state = "COMPLETED"

        game_customtimer.startGame(start_interval);
        //game_customtimer.start_looping()

        //game_start.start()
    }

    Component.onDestruction: {
        game_main.escpress_signal.disconnect(to_main)
        game_main.uppress_signal.disconnect(increase_hispeed)
        game_main.downpress_signal.disconnect(decrease_hispeed)

        game_main.spacepress_signal.disconnect(hit)
        game_main.enterpress_signal.disconnect(swipe)
    }

    /*Timer {
        id: game_start
        interval: start_interval
        onTriggered: {
            game_process.startGame()
        }
    }*/

    signal hit ()
    signal swipe ()
}
