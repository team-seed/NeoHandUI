import QtQuick 2.0
import QtQuick.Shapes 1.12

Shape {
    property int start_time: 0
    property int end_time: 0
    property double bpm: 120.0
    property int window: game_customtimer.clock - start_time
    property int gesture: 0

    property double shape_height: -(bpm * hispeed * (end_time - start_time)) / parent.height
    property string shape_color: "white"
    property double right_top: 0
    property double right_bottom: 0
    property double left_bottom: 0

    id: shape
    antialiasing: true

    visible: (y + shape_height) > 0

    y: (bpm * hispeed * window) / parent.height  + (parent.height - judge_position) + shape_height

    ShapePath {
        id: sPath
        strokeColor: "whitesmoke"
        strokeWidth: 2
        fillGradient: LinearGradient {
            GradientStop { position: 0; color: "whitesmoke" }
            GradientStop { position: 1; color: shape_color }
        }

        startX: 0; startY: 0
        PathLine { x: right_top; y: 0 }
        PathLine { x: right_bottom; y: shape_height }
        PathLine { x: left_bottom; y: shape_height }
        PathLine { x: 0; y: 0 }
    }
}
