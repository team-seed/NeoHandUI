import QtQuick 2.0

Text {
    width:parent.width
    height: parent.height/7

    FontLoader { id: font_Genjyuu_XP_bold; source: "qrc:/font/GenJyuuGothicX-P-Bold.ttf" }
    FontLoader { id: good_time; source: "qrc:/font/good-times-rg.ttf" }

    font.family: font_Genjyuu_XP_bold.name
    font.pointSize: 20
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter

    color: focus ? "red" : "gray"
}
