import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    property int time: 0
    property double bpm: 120.0
    property int dirc: 0

    property int window: game_customtimer.clock - time

    id: swipe_note
    height: judge_height
    antialiasing: true

    visible: y > 0

    y: (bpm * hispeed * window) / parent.height  + (parent.height - judge_position)

    border {
        color: "whitesmoke"
        width: 2
    }

    function check_swipe () {
        if (Math.abs(window) < 40) {
//            console.log("exact, " + window)
            swipe_note.destroy()
        }
        else if (Math.abs(window) < 80) {
//            if (window > 0) console.log("late, " + window)
//            else console.log("early, " + window)
            swipe_note.destroy()
        }
    }

    Component.onCompleted: {
        swipe.connect(check_swipe)
    }
}
