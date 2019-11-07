import QtQuick 2.12
import QtQuick.Controls 2.12

Column{
    anchors.fill: parent
    Header{ text: "SETTINGS" }

    SelectBar {
        id: game_start
        text:"GAME START"
        focus: true
        Keys.onPressed: {
            if(event.key == Qt.Key_Return || event.key == Qt.Key_Right){
                pageloader.source = "/ui/game/Game.qml"
                event.accepted = true;
            }
        }
        KeyNavigation.up: quit
        KeyNavigation.down: button_test
    }
    SelectBar {
        id: button_test
        text:"BUTTON TEST"

        Keys.onPressed: {
            if (event.key == Qt.Key_Return || event.key == Qt.Key_Right) {
                pageloader.source ="button_test.qml"
                event.accepted = true;
            }
       }
        KeyNavigation.up: game_start
        KeyNavigation.down: camera_test
    }
    SelectBar {
        id: camera_test
        text:"CAMERA TEST"

        Keys.onPressed: {
            if(event.key == Qt.Key_Return || event.key == Qt.Key_Right){
                pageloader.source = "camera_test.qml"
                event.accepted = true;
            }
        }
        KeyNavigation.up: button_test
        KeyNavigation.down: network_test
    }
    SelectBar {
        id: network_test
        text:"NETWORK TEST"

        Keys.onPressed: {
            if(event.key == Qt.Key_Return || event.key == Qt.Key_Right){
                pageloader.source = "network_test.qml"
                event.accepted = true;
            }
        }
        KeyNavigation.up: camera_test
        KeyNavigation.down: param_setting
    }
    SelectBar {
        id: param_setting
        text:"PARAM SETTING"

        Keys.onPressed: {
            if(event.key == Qt.Key_Return || event.key == Qt.Key_Right){
                pageloader.source = "param_setting.qml"
                event.accepted = true;
            }
        }
        KeyNavigation.up: network_test
        KeyNavigation.down: quit
    }
    SelectBar {
        id: quit
        text:"QUIT"

        Keys.onPressed: {
            if(event.key == Qt.Key_Return || event.key == Qt.Key_Right){
               Qt.quit()
               event.accepted = true;
            }
        }
        KeyNavigation.up: param_setting
        KeyNavigation.down: game_start
    }
}
