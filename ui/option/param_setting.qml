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
    Header{ text:"PARAM  SETTING" }

    Rectangle {
        width: 300
        height: 5
        color: "seashell"
    }

    Component.onCompleted:{
        //game_main.leftpress_signal.connect(tomain)
        game_main.bksppress_signal.connect(tomain)
    }

    function tomain () {pageloader.source = "mainPanel.qml"}

    Component.onDestruction: {
        //game_main.leftpress_signal.disconnect(tomain)
        game_main.bksppress_signal.disconnect(tomain)
    }
}
