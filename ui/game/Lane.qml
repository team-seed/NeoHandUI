import QtQuick 2.0
import QtGraphicalEffects 1.0

import "game_process_extension.js" as GP

Item {
    id: lane_full
    property alias game_lane: lane_full

    property int side_width: parent.width / 40
    property int judge_height: side_width //* 2
    property int separater_width: 1
    property int lane_count: 4
    property int partitions_per_lane: 4
    property double part_width: lane_row.width / lane_count / partitions_per_lane
    property double judge_position: parent.height / 12

    Item {
        id: lane_row
        height: parent.height
        anchors {
            left: lane_side_left.right
            right: lane_side_right.left
        }
    }

    LinearGradient {
        id: gradient_lane_mask
        antialiasing: true
        opacity: 0.4
        anchors.fill: lane_row
        gradient: Gradient {
            GradientStop { position: 0.00; color: "transparent" }
            GradientStop { position: 0.20; color: "white" }
            GradientStop { position: 0.95; color: "white" }
            GradientStop { position: 0.99; color: "transparent" }
        }
    }

    Blend {
        anchors.fill: lane_row
        source: lane_row
        foregroundSource: gradient_lane_mask
        mode: "hue"
    }

    Rectangle {
        id: lane_side_left
        antialiasing: true
        height: parent.height
        width: side_width
        opacity: 0.9

        anchors {
            left: parent.left
        }

        gradient: Gradient {
            GradientStop { position: 0.00; color: "transparent" }
            GradientStop { position: 0.20; color: "#444444" }
            GradientStop { position: 0.95; color: "#222222" }
            GradientStop { position: 0.98; color: "transparent" }
        }

    }

    Rectangle {
        id: lane_side_right
        antialiasing: true
        height: parent.height
        width: side_width
        opacity: lane_side_left.opacity

        anchors {
            right: parent.right
        }

        gradient: Gradient {
            GradientStop { position: 0.00; color: "transparent" }
            GradientStop { position: 0.20; color: "#444444" }
            GradientStop { position: 0.95; color: "#222222" }
            GradientStop { position: 0.98; color: "transparent" }
        }
    }

    Row {
        opacity: 0.7
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
        }
        height: parent.height
        spacing: lane_row.width / lane_count - separater_width

        Repeater {
            model: 3

            Rectangle {
                antialiasing: true
                height: parent.height
                width: separater_width
                //color: "#BBBBBB"
                gradient: Gradient {
                    GradientStop { position: 0.00; color: "transparent" }
                    GradientStop { position: 0.30; color: "#BBBBBB" }
                    GradientStop { position: 0.90; color: "#DDDDDD" }
                    GradientStop { position: 0.97; color: "transparent" }
                }
            }
        }
    }

    Rectangle {
        id: judge_line

        color: "#353535"
        //radius: 30
        opacity: 0.8

        height: judge_height
        width: parent.width - side_width * 2

        anchors {
            left: lane_side_left.right
            right: lane_side_right.left
            bottom: parent.bottom
            bottomMargin: judge_position - height
            verticalCenterOffset: height
        }
    }

    function make_chart () {
        game_process.chart.forEach(value => {
            if (Array.isArray(value)) {
                switch (value[0]) {
                case 0:
                    GP.generateNote(value[1], value[2], value[3], value[4], value[5])
                    break
                case 1: break
                case 2:
                    GP.generateSwipe(value[6], value[2], value[3], value[4], value[5])
                    break
                case -1:
                    console.log("line"); break
                }
            }
            else {
                console.log(value);
            }
        });
    }

}
