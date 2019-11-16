import QtQuick 2.12
import QtQuick.Controls 2.12

Column{
    spacing: 20
    anchors {
        top: parent.top
        bottom: parent.bottom
        left: parent.left
        right: parent.right
        topMargin: 90
        bottomMargin: 90
        leftMargin: 160
        rightMargin: 160
    }

    FontLoader { id: font_Genjyuu_XP_bold; source: "qrc:/font/GenJyuuGothicX-P-Bold.ttf" }
    Header{ id:header; text:"BUTTON  TEST" }

    Rectangle {
        width: 300
        height: 5
        color: "seashell"
    }

    MyButton{
        id: up
        Text { anchors.centerIn: parent; color: "gray"; text: "UP"; font.pixelSize: parent.height; font.family:font_Genjyuu_XP_bold.name}
    }
    MyButton{
        id: down
        Text { anchors.centerIn: parent; color: "gray"; text: "DOWN"; font.pixelSize: parent.height; font.family:font_Genjyuu_XP_bold.name}
    }
    MyButton{
        id: left
        Text { anchors.centerIn: parent; color: "gray"; text: "LEFT"; font.pixelSize: parent.height; font.family:font_Genjyuu_XP_bold.name}
    }
    MyButton{
        id: right
        Text { anchors.centerIn: parent; color: "gray"; text: "RIGHT"; font.pixelSize: parent.height; font.family:font_Genjyuu_XP_bold.name}
    }

    MyButton{
        id: enter
        Text { anchors.centerIn: parent; color: "gray"; text: "ENTER"; font.pixelSize: parent.height; font.family:font_Genjyuu_XP_bold.name}
    }

    MyButton{
        id: space
        Text { anchors.centerIn: parent; color: "gray"; text: "SPACE"; font.pixelSize: parent.height; font.family:font_Genjyuu_XP_bold.name}
    }
    MyButton{
        id: backspace
        Text { anchors.centerIn: parent; color: "gray"; text: "BKSP"; font.pixelSize: parent.height; font.family:font_Genjyuu_XP_bold.name}
    }
    MyButton{
        id: esc
        Text { anchors.centerIn: parent; color: "gray"; text: "ESC"; font.pixelSize: parent.height; font.family:font_Genjyuu_XP_bold.name}
    }

    Text{
        color: "white"
        font.family: font_Genjyuu_XP_bold.name
        font.pixelSize: 40

        text:"ESC + BKSP  TO  RETURN"
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
        game_main.enterrelease_signal.connect(enterrelease)
        game_main.spacerelease_signal.connect(spacerelease)
        game_main.bksprelease_signal.connect(bksprelease)
        game_main.escrelease_signal.connect(escrelease)
    }

    function uppress(){up.state = "Pressed"}
    function downpress(){down.state = "Pressed"}
    function leftpress(){left.state = "Pressed"}
    function rightpress(){right.state = "Pressed"}
    function enterpress(){enter.state = "Pressed"}
    function spacepress(){space.state = "Pressed"}
    function bksppress(){backspace.state = "Pressed"; if (esc.state == "Pressed") {pageloader.source = "mainPanel.qml"}}
    function escpress(){esc.state = "Pressed"; if (backspace.state == "Pressed") {pageloader.source = "mainPanel.qml"}}

    function uprelease(){up.state = "Released"}
    function downrelease(){down.state = "Released"}
    function leftrelease(){left.state = "Released"}
    function rightrelease(){right.state = "Released"}
    function enterrelease(){enter.state = "Released"}
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
        game_main.enterrelease_signal.disconnect(enterrelease)
        game_main.spacerelease_signal.disconnect(spacerelease)
        game_main.escrelease_signal.disconnect(escrelease)
        game_main.bksprelease_signal.disconnect(bksprelease)
    }
}
