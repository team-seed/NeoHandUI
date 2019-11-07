import QtQuick 2.12
import QtQuick.Controls 2.12

Column{
    anchors.fill:parent
    FontLoader { id: good_time; source: "qrc:/font/good-times-rg.ttf" }
    Header{ id:header;text:"BUTTON TEST" }

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

}
