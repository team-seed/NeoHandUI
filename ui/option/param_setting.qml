import QtQuick 2.12
import QtQuick.Controls 2.12

Column{
    anchors.fill:parent
    Header{ text:"PARAM SETTING" }

    Component.onCompleted:{
        game_main.leftpress_signal.connect(tomain)
        game_main.bksppress_signal.connect(tomain)
    }

    function tomain(){pageloader.source = "mainPanel.qml"}

    Component.onDestruction: {
        game_main.leftpress_signal.disconnect(tomain)
        game_main.bksppress_signal.disconnect(tomain)
    }
}
