import QtQuick 2.0

Item {
    id: combo_box
    opacity: 0.7

    width: parent.width / 4
    height: parent.height / 4

    property double pointheight: this.height / 20

    Text {
        id: combo_max
        text: "MAX 9999"
        color: "white"

        font.family: font_good_times.name
        font.pixelSize: pointheight * 2

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
        }
    }

    Text {
        id: combo_count

        property int total_combo: 0

        text: total_combo.toString();
        color: "white"

        font.family: font_good_times.name
        font.pixelSize: pointheight * 8


        anchors {
            horizontalCenter: parent.horizontalCenter
            top: combo_max.bottom
        }
    }

    Text {
        id: combo
        text: "COMBO"
        color: "white"

        font.family: font_good_times.name
        font.pixelSize: pointheight * 3

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: combo_count.bottom
        }
    }

    Rectangle {
        height: 50
        width: 50
        radius: 30

        color: "cyan"

        anchors {
            top: parent.top
            left: parent.left
        }

        MouseArea {
            anchors.fill: parent

            onClicked: function () {
                combo_count.total_combo++;
            };
        }

        Text {
            text: qsTr("ADD")
            anchors.centerIn: parent
        }
    }


    FontLoader {
        id: font_good_times
        source: "/font/good-times-rg.ttf"
    }
}
