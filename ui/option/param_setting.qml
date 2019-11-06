import QtQuick 2.12
import QtQuick.Controls 2.12

Column{
    anchors.fill:parent
    FontLoader { id: font_Genjyuu_XP_bold; source: "qrc:/font/GenJyuuGothicX-P-Bold.ttf" }
    focus: true
    Keys.onPressed: {
        if(event.key == Qt.Key_Left || Qt.Key_Backspace){
            pageloader.source = "mainPanel.qml"
        }
    }
    Text{
        width: parent.width
        height: parent.height/6

        text:"PARAM SETTING"
        font.italic: true
        font.bold: true
        font.pointSize: 30
        font.family: font_Genjyuu_XP_bold.name
        color: "white"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
}
