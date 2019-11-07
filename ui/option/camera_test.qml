import QtQuick 2.12
import QtQuick.Controls 2.12

Column{
    anchors.fill:parent
    Header{ text:"CAMERA TEST" }
    focus: true
    Keys.onPressed: {
        if(event.key == Qt.Key_Left || Qt.Key_Backspace){
            pageloader.source = "mainPanel.qml"
        }
    }
}
