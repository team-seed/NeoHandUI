import QtQuick 2.12
import QtQuick.Controls 2.12

Column{
    anchors.fill:parent
    FontLoader { id: font_Genjyuu_XP_bold; source: "qrc:/font/GenJyuuGothicX-P-Bold.ttf" }
    FontLoader { id: good_time; source: "qrc:/font/good-times-rg.ttf" }
    focus: true
    Keys.onPressed: {
        if(event.key == Qt.Key_Return){
            pageloader.source = "mainPanel.qml"
        }
        else if(event.key==Qt.Key_Up)
            up.state = "Pressed"
        else if(event.key==Qt.Key_Down)
            down.state = "Pressed"
        else if(event.key==Qt.Key_Left)
            left.state = "Pressed"
        else if(event.key==Qt.Key_Right)
            right.state = "Pressed"
        else if(event.key==Qt.Key_Space)
            space.state = "Pressed"
        else if(event.key==Qt.Key_Backspace)
            backspace.state = "Pressed"
        else if(event.key==Qt.Key_Escape)
            esc.state = "Pressed"

    }
    Keys.onReleased: {
        if(event.key==Qt.Key_Up)
            up.state = "Released"
        else if(event.key==Qt.Key_Down)
            down.state = "Released"
        else if(event.key==Qt.Key_Left)
            left.state = "Released"
        else if(event.key==Qt.Key_Right)
            right.state = "Released"
        else if(event.key==Qt.Key_Space)
            space.state = "Released"
        else if(event.key==Qt.Key_Backspace)
            backspace.state = "Released"
        else if(event.key==Qt.Key_Escape)
            esc.state = "Released"
    }

    Text{
        width: parent.width
        height: parent.height/6

        text:"BUTTON TEST"
        font.italic: true
        font.bold: true
        font.pointSize: 30
        fontSizeMode: Text.Fit
        font.family: font_Genjyuu_XP_bold.name
        color: "white"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
    MyButton{
        id:up
        height: parent.height/12
        width:parent.width
        Text { anchors.centerIn: parent;text: qsTr("UP");font.family:good_time.name}
    }

    MyButton{
        id:down
        height: parent.height/12
        width:parent.width
        Text { anchors.centerIn: parent;text: qsTr("DOWN");font.family:good_time.name}
    }
    MyButton{
        id:left
        height: parent.height/12
        width:parent.width
        Text { anchors.centerIn: parent;text: qsTr("LEFT");font.family:good_time.name}
    }
    MyButton{
        id:right
        height: parent.height/12
        width:parent.width
        Text { anchors.centerIn: parent;text: qsTr("RIGHT");font.family:good_time.name}
    }
    MyButton{
        id:space
        height: parent.height/12
        width:parent.width
        Text { anchors.centerIn: parent;text: qsTr("SPACE");font.family:good_time.name}
    }
    MyButton{
        id:backspace
        height: parent.height/12
        width:parent.width
        Text { anchors.centerIn: parent;text: qsTr("BACKSPACE");font.family:good_time.name}
    }
    MyButton{
        id:esc
        height: parent.height/12
        width:parent.width
        Text { anchors.centerIn: parent;text: qsTr("ESC");font.family:good_time.name}
    }

    Text{
        color: "white"
        font.family: font_Genjyuu_XP_bold.name
        height: parent.height/8
        width:parent.width
        font.pointSize: 20

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text:"按下Enter以結束BUTTON TEST"
    }

}
