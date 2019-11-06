import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id:window
    visible: true
    width: 640
    height: 480

    Loader{
        id:pageloader
        width:parent.width/2
        height: parent.height/2
        focus: true
        source: "mainPanel.qml"
    }
}
