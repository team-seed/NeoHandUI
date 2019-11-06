import QtQuick 2.12
import QtQuick.Controls 2.12

Column{
    anchors.fill: parent
    spacing: 10
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
        width:parent.width
        height:parent.height/4
        text:"BUTTON TEST"
    }
    MyButton{
        id:up
        Text { anchors.centerIn: parent;text: qsTr("UP")}
    }

    MyButton{
        id:down
        Text { anchors.centerIn: parent;text: qsTr("DOWN")}
    }
    MyButton{
        id:left
        Text { anchors.centerIn: parent;text: qsTr("LEFT")}
    }
    MyButton{
        id:right
        Text { anchors.centerIn: parent;text: qsTr("RIGHT")}
    }
    MyButton{
        id:space
        Text { anchors.centerIn: parent;text: qsTr("SPACE")}
    }
    MyButton{
        id:backspace
        Text { anchors.centerIn: parent;text: qsTr("BACKSPACE")}
    }
    MyButton{
        id:esc
        Text { anchors.centerIn: parent;text: qsTr("ESC")}
    }

    Text{
        width: parent.width
        height: parent.height/4
        text:"按下Enter以結束BUTTON TEST"
    }

}
