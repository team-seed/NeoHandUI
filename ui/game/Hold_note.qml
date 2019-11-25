import QtQuick 2.0
import QtQuick.Shapes 1.12

Shape {
    property int start_time: 0
    property int end_time: 0
    property double bpm: 120.0
    property int window: game_customtimer.clock - start_time
    property int gesture: 0

    property double shape_height: (bpm * hispeed * (end_time - start_time)) / parent.height
    property string shape_color: "green"
    property double right_top: 0
    property double right_bottom: 0
    property double left_top: 0
    property double left_bottom: 0

    id: shape
    antialiasing: true

    visible: y + shape_height > 0

    y: (bpm * hispeed * (game_customtimer.clock - end_time)) / parent.height  + (parent.height + judge_height - judge_position)
    ShapePath {
        id: sPath
        strokeColor: "whitesmoke"
        strokeWidth: 2
        fillColor: shape_color

        startX: left_top; startY: 0
        PathLine { x: right_top; y: 0 }
        PathLine { x: right_bottom; y: shape_height }
        PathLine { x: left_bottom; y: shape_height }
        PathLine { x: left_top; y: 0 }
    }
}
