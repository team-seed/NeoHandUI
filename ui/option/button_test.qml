import QtQuick 2.12
import QtQuick.Controls 2.12

Column{
    anchors.fill:parent
    FontLoader { id: good_time; source: "qrc:/font/good-times-rg.ttf" }
    Header{ id:header;text:"BUTTON TEST" }

    MyButton{
        id:up
        Text { anchors.centerIn: parent;text: qsTr("UP");font.family:good_time.name}
    }
    MyButton{
        id:down
        Text { anchors.centerIn: parent;text: qsTr("DOWN");font.family:good_time.name}
    }
    MyButton{
        id:left
        Text { anchors.centerIn: parent;text: qsTr("LEFT");font.family:good_time.name}
    }
    MyButton{
        id:right
        Text { anchors.centerIn: parent;text: qsTr("RIGHT");font.family:good_time.name}
    }
    MyButton{
        id:space
        Text { anchors.centerIn: parent;text: qsTr("SPACE");font.family:good_time.name}
    }
    MyButton{
        id:backspace
        Text { anchors.centerIn: parent;text: qsTr("BACKSPACE");font.family:good_time.name}
    }
    MyButton{
        id:esc
        Text { anchors.centerIn: parent;text: qsTr("ESC");font.family:good_time.name}
    }

    Text{
        color: "white"
        font.family: good_time.name
        height: parent.height/8
        width:parent.width
        font.pointSize: 20

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text:"按下Enter以結束BUTTON TEST"
    }

    Component.onCompleted: {
        //press
        game_main.uppress_signal.connect(uppress)
        game_main.downpress_signal.connect(downpress)
        game_main.leftpress_signal.connect(leftpress)
        game_main.rightpress_signal.connect(rightpress)
        game_main.enterpress_signal.connect(enterpress)
        game_main.spacepress_signal.connect(spacepress)
        game_main.bksppress_signal.connect(bksppress)
        game_main.escpress_signal.connect(escpress)

        //release
        game_main.uprelease_signal.connect(uprelease)
        game_main.downrelease_signal.connect(downrelease)
        game_main.leftrelease_signal.connect(leftrelease)
        game_main.rightrelease_signal.connect(rightrelease)
        game_main.spacerelease_signal.connect(spacerelease)
        game_main.bksprelease_signal.connect(bksprelease)
        game_main.escrelease_signal.connect(escrelease)
    }

    function uppress(){up.state = "Pressed"}
    function downpress(){down.state = "Pressed"}
    function leftpress(){left.state = "Pressed"}
    function rightpress(){right.state = "Pressed"}
    function enterpress(){pageloader.source = "mainPanel.qml"}
    function spacepress(){space.state = "Pressed"}
    function bksppress(){backspace.state = "Pressed"}
    function escpress(){esc.state = "Pressed"}

    function uprelease(){up.state = "Released"}
    function downrelease(){down.state = "Released"}
    function leftrelease(){left.state = "Released"}
    function rightrelease(){right.state = "Released"}
    function spacerelease(){space.state = "Released"}
    function bksprelease(){backspace.state = "Released"}
    function escrelease(){esc.state = "Released"}

    Component.onDestruction: {
        game_main.uppress_signal.disconnect(uppress)
        game_main.downpress_signal.disconnect(downpress)
        game_main.leftpress_signal.disconnect(leftpress)
        game_main.rightpress_signal.disconnect(rightpress)
        game_main.enterpress_signal.disconnect(enterpress)
        game_main.spacepress_signal.disconnect(spacepress)
        game_main.bksppress_signal.disconnect(bksppress)
        game_main.escpress_signal.disconnect(escpress)

        game_main.uprelease_signal.disconnect(uprelease)
        game_main.downrelease_signal.disconnect(downrelease)
        game_main.leftrelease_signal.disconnect(leftrelease)
        game_main.rightrelease_signal.disconnect(rightrelease)
        game_main.spacerelease_signal.disconnect(spacerelease)
        game_main.escrelease_signal.disconnect(escrelease)
        game_main.bksprelease_signal.disconnect(bksprelease)
    }
}
