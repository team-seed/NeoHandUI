import QtQuick 2.12
import QtQuick.Controls 2.12

Grid{
    anchors.fill: parent
    columns:1
    Text{
        width:parent.width
        height:parent.height/6
        text:"SETTINGS"
    }

    Text {
        id: button_test
        text:"BUTTON TEST"
        width:parent.width;height: parent.height/6
        color: focus ? "red" : "gray"
        focus: true

        Keys.onPressed: {
            if (event.key == Qt.Key_Return || event.key == Qt.Key_Right) {
                console.log("BUTTON TEST");
                pageloader.source ="button_test.qml"
                event.accepted = true;
            }
       }
        KeyNavigation.up: exit
        KeyNavigation.down: camera_test
    }

    Text {
        id: camera_test
        text:"CAMERA TEST"
        width:parent.width;height: parent.height/6
        color: focus ? "red" : "gray"

        Keys.onPressed: {
            if(event.key == Qt.Key_Return || event.key == Qt.Key_Right){
                console.log("CAMERA TEST");
                event.accepted = true;
            }
        }
        KeyNavigation.up: button_test
        KeyNavigation.down: network_test
    }

    Text {
        id: network_test
        text:"NERWORK TEST"
        width:parent.width;height: parent.height/6
        color: focus ? "red" : "gray"

        Keys.onPressed: {
            if(event.key == Qt.Key_Return || event.key == Qt.Key_Right){
                console.log("NETWORK TEST");
                event.accepted = true;
            }
        }
        KeyNavigation.up: camera_test
        KeyNavigation.down: param_setting
    }

    Text {
        id: param_setting
        text:"PARAM SETTING"
        width:parent.width;height: parent.height/6
        color: focus ? "red" : "gray"

        Keys.onPressed: {
            if(event.key == Qt.Key_Return || event.key == Qt.Key_Right){
                console.log("PARAM SETTING");
                event.accepted = true;
            }
        }
        KeyNavigation.up: network_test
        KeyNavigation.down: game_start
    }
    Text {
        id: game_start
        text:"GAME START"
        width:parent.width;height: parent.height/6
        color: focus ? "red" : "gray"

        Keys.onPressed: {
            if(event.key == Qt.Key_Return || event.key == Qt.Key_Right){
                console.log("GAME START");
                pageloader.source = "/main.qml"
                event.accepted = true;
            }
        }
        KeyNavigation.up: param_setting
        KeyNavigation.down: exit
    }
    Text {
        id: exit
        text:"EXIT"
        width:parent.width;height: parent.height/6
        color: focus ? "red" : "gray"

        Keys.onPressed: {
            if(event.key == Qt.Key_Return || event.key == Qt.Key_Right){
                window.close()
                event.accepted = true;
            }
        }
        KeyNavigation.up: game_start
        KeyNavigation.down: button_test
    }
}
