import QtQuick 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.0

import custom.game.process 1.0
import custom.game.timer 1.0
import gesture 1.0

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
    property int score: 800000 * (accuracy / total_note_count) + 200000 * (game_core.max_combo / total_note_count)
    property int mybest: 0

    property int total_note_count: 0
    property double accuracy: 0
    property int exact_count: 0
    property int close_count: 0
    property int break_count: 0

    property double lane_length: 760 + 32 * parent.height / 1080
    property double side_length: 760 + 32 * parent.height / 1080
    property double lane_angle: 90 - 15 * parent.height / 1080
    property double side_angle: 89.875 - 12.875 * parent.height / 1080

    property bool enable: false

    CustomGameProcess { id: game_process }

    CustomGameTimer { id: game_customtimer }

    Gesture { id: gesture_engine }

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

    Sideleft { id: game_screen_side_left }

    Sideright { id: game_screen_side_right }

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

    Metadata {}

    Bottomline {
        id: life
    }

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

    function gameover () {
        disconnect_all()
        game_transition.state = "LOADING"
        final_score = score
        var data = [total_note_count, exact_count, close_count, break_count, accuracy / total_note_count * 100, game_core.max_combo]
        result_data = data
        destruct.start()
    }

    function enable_up () { enable = true }
    function enable_down () { enable = false }

    function disconnect_all () {
        gesture_engine.trigger.disconnect(hit)
        gesture_engine.trigger.disconnect(enable_up)
        gesture_engine.untrigger.disconnect(release)
        gesture_engine.untrigger.disconnect(enable_down)
        gesture_engine.up_swipe.disconnect(swipe_up)
        gesture_engine.down_swipe.disconnect(swipe_down)
        gesture_engine.left_swipe.disconnect(swipe_left)
        gesture_engine.right_swipe.disconnect(swipe_right)

        game_main.escpress_signal.disconnect(to_main)
        game_main.uppress_signal.disconnect(increase_hispeed)
        game_main.downpress_signal.disconnect(decrease_hispeed)

        game_main.enterpress_signal.disconnect(gameover)
    }

    Component.onCompleted: {
        set_value();
        game_process.song_chart_parse((game_main.song_data[0] + (expert ? "/expert.json" : "/basic.json")));
        game_lane_outside.make_chart();
        game_customtimer.set_song("file:///" + game_main.song_data[0] + "/audio.wav");

        gesture_engine.start()
        gesture_engine.trigger.connect(hit)
        gesture_engine.trigger.connect(enable_up)
        gesture_engine.untrigger.connect(release)
        gesture_engine.untrigger.connect(enable_down)
        gesture_engine.up_swipe.connect(swipe_up)
        gesture_engine.down_swipe.connect(swipe_down)
        gesture_engine.left_swipe.connect(swipe_left)
        gesture_engine.right_swipe.connect(swipe_right)

        game_main.escpress_signal.connect(to_main)
        game_main.uppress_signal.connect(increase_hispeed)
        game_main.downpress_signal.connect(decrease_hispeed)

        game_main.enterpress_signal.connect(gameover)

        game_transition.state = "COMPLETED"

        game_customtimer.startGame(start_interval);
    }

    Component.onDestruction: {
        disconnect_all()
    }

    Timer {
        id: destruct
        interval: game_transition.time
        onTriggered: pageloader.source = "/ui/home/Result.qml"
    }

    signal hit ()
    signal release ()
    signal swipe_up ()
    signal swipe_down ()
    signal swipe_left ()
    signal swipe_right ()
}
