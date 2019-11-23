import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    property int time: 0
    property double bpm: 120.0
    property int window: game_customtimer.clock - time

    id: click
    height: judge_height
    antialiasing: true

    visible: y > 0

    y: (bpm * hispeed * window) / parent.height  + (parent.height - judge_position)

    border {
        color: "whitesmoke"
        width: 2
    }

    function check_hit () {
        //var window
        //window = Math.abs((game_customtimer.clock - time))
        if (Math.abs(window) < 40) {
            console.log("exact")
            click.destroy()
        }
        else if (Math.abs(window) < 80) {
            if (window > 0) console.log("late")
            else console.log("early")
            click.destroy()
        }
    }

    Component.onCompleted: {
        hit.connect(check_hit)
    }
}
