import QtQuick 2.12
import QtQuick.Controls 2.12

Column {
    property int select_index: 0
    property string version: "NH2:SL.20191117.1b"

    spacing: 20

    anchors {
        top: parent.top
        bottom: parent.bottom
        left: parent.left
        right: parent.right
        topMargin: 90
        bottomMargin: 90
        leftMargin: 160
        rightMargin: 160
    }

    Header{ text: "NeoHand 2: SEED OF LEGGENDARIA" }

    Text {
        text: version
        color: "gray"
        font.family: font_Genjyuu_XP_bold.name
        font.pixelSize: parent.height / 30
    }

    Rectangle {
        width: 300
        height: 5
        color: "seashell"
    }

    SelectBar {
        id: game_start
        text:"GAME  START"
        color: select_index == 0 ? "red" : "gray"
    }
    SelectBar {
        id: button_test
        text:"BUTTON  TEST"
        color: select_index == 1 ? "red" : "gray"
    }
    SelectBar {
        id: camera_test
        text:"CAMERA  TEST"
        color: select_index == 2 ? "red" : "gray"
    }
    SelectBar {
        id: network_test
        text:"NETWORK  TEST"
        color: select_index == 3 ? "red" : "gray"
    }
    SelectBar {
        id: param_setting
        text:"PARAM  SETTING"
        color: select_index == 4 ? "red" : "gray"
    }
    SelectBar {
        id: quit
        text:"QUIT"
        color: select_index == 5 ? "red" : "gray"
    }


    Component.onCompleted: {
        game_main.uppress_signal.connect(up)
        game_main.downpress_signal.connect(down)
        game_main.enterpress_signal.connect(page_switch)
        game_main.rightpress_signal.connect(page_switch)

        game_transition.state = "COMPLETE"
    }

    function up(){
        select_index = (select_index+5) % 6
    }

    function down(){
        select_index = (++select_index) % 6
    }

    function page_switch() {
        switch (select_index){
            case 0:
                game_transition.state = "LOADING"
                disconnect_all()
                destruct.start()
                break
            case 1:
                pageloader.source = "button_test.qml"
                break
            case 2:
                pageloader.source = "camera_test.qml"
                break
            case 3:
                pageloader.source = "network_test.qml"
                break
            case 4:
                pageloader.source = "param_setting.qml"
                break
            case 5:
                Qt.quit()
                break
        }
    }

    function disconnect_all() {
        game_main.uppress_signal.disconnect(up)
        game_main.downpress_signal.disconnect(down)
        game_main.rightpress_signal.disconnect(page_switch)
        game_main.enterpress_signal.disconnect(page_switch)
    }

    Component.onDestruction: {
        disconnect_all()
    }

    Timer {
        id: destruct
        interval: game_transition.time
        onTriggered: pageloader.source = "/ui/songselect/Songselect.qml"
    }

    FontLoader { id: font_Genjyuu_XP_bold; source: "qrc:/font/GenJyuuGothicX-P-Bold.ttf" }
}
