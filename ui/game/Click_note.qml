import QtQuick 2.12
import QtGraphicalEffects 1.0
import "game_process_extension.js" as GP

Rectangle {
    property int time: 0
    property double bpm: 120.0
    property int window: game_customtimer.clock - time
    property int gesture: 0

    id: click
    height: judge_height
    antialiasing: true

    visible: y > 0

    y: (bpm * hispeed * window) / parent.height  + (parent.height - judge_position)

    border {
        color: "whitesmoke"
        width: 2
    }

    onWindowChanged: {
        if (window > 150) {
            GP.generateMark(window)
            click.destroy()
        }
    }

    function check_hit () {
        var timing = Math.abs(window)
        if (timing > 150) return

        GP.generateMark(timing)
        click.destroy()
    }

    Component.onCompleted: {
        hit.connect(check_hit)
    }

    Component.onDestruction: {
        hit.disconnect(check_hit)
    }
}
