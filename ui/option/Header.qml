import QtQuick 2.0

Text{
    width: parent.width
    height: parent.height/6

    FontLoader { id: font_Genjyuu_XP_bold; source: "qrc:/font/GenJyuuGothicX-P-Bold.ttf" }
    FontLoader { id: good_time; source: "qrc:/font/good-times-rg.ttf" }

    font.italic: true
    font.bold: true
    font.pointSize: 30
    font.family: font_Genjyuu_XP_bold.name
    color: "white"
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
}
