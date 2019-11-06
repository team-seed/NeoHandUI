import QtQuick 2.12
import QtQuick.Controls 2.12
Column{
    anchors.fill: parent
    FontLoader { id: font_Genjyuu_XP_bold; source: "qrc:/font/GenJyuuGothicX-P-Bold.ttf" }
    Text{
        width: parent.width
        height: parent.height/6
        text: "SETTINGS"
        font.family: font_Genjyuu_XP_bold.name
        font.italic: true
        font.bold: true
        font.pointSize: 30
        fontSizeMode: Text.Fit
        color: "white"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        width:parent.width
        height: parent.height/7
        id: button_test
        text:"BUTTON TEST"
        font.family: font_Genjyuu_XP_bold.name
        font.pointSize: 20
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.Fit
        horizontalAlignment: Text.AlignHCenter
        color: focus ? "red" : "gray"
        focus: true

        Keys.onPressed: {
            if (event.key == Qt.Key_Return || event.key == Qt.Key_Right) {
                console.log("BUTTON TEST");
                pageloader.source ="button_test.qml"
                event.accepted = true;
            }
       }
        KeyNavigation.up: quit
        KeyNavigation.down: camera_test
    }

    Text {
        id: camera_test
        width:parent.width
        height: parent.height/7
        text:"CAMERA TEST"
        font.family: font_Genjyuu_XP_bold.name
        font.pointSize: 20
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.Fit
        horizontalAlignment: Text.AlignHCenter
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
        text:"NETWORK TEST"
        font.family: font_Genjyuu_XP_bold.name
        font.pointSize: 20
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.Fit
        width:parent.width
        height: parent.height/7
        horizontalAlignment: Text.AlignHCenter
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
        font.family: font_Genjyuu_XP_bold.name
        font.pointSize: 20
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.Fit
        width:parent.width
        height: parent.height/7
        horizontalAlignment: Text.AlignHCenter
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
        font.family: font_Genjyuu_XP_bold.name
        font.pointSize: 20
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.Fit
        width:parent.width
        height: parent.height/7
        horizontalAlignment: Text.AlignHCenter
        color: focus ? "red" : "gray"

        Keys.onPressed: {
            if(event.key == Qt.Key_Return || event.key == Qt.Key_Right){
                console.log("GAME START");
               pageloader.source = "/ui/game/Game.qml"
                event.accepted = true;
            }
        }
        KeyNavigation.up: param_setting
        KeyNavigation.down: quit
    }
    Text {
        id: quit
        text:"QUIT"
        font.family: font_Genjyuu_XP_bold.name
        font.pointSize: 20
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.Fit
        width:parent.width
        height: parent.height/7
        horizontalAlignment: Text.AlignHCenter
        color: focus ? "red" : "gray"

        Keys.onPressed: {
            if(event.key == Qt.Key_Return || event.key == Qt.Key_Right){
               Qt.quit()
               event.accepted = true;
            }
        }
        KeyNavigation.up: game_start
        KeyNavigation.down: button_test
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
