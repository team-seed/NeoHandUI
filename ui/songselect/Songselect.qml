import QtQuick 2.12

import custom.songselect 1.0

Item {
    id: songselect_container

    property variant songs_meta: dir.content
    property int song_index: select_list.currentIndex
    property int page_count: 4
    property bool select_expert: false

    CustomSongselect { id: dir }

    Image {
        id: songselect_background
        opacity: 0.5
        source: "file:///" + songs_meta[song_index][0] + "/bg.png"

        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
    }

    Text {
        id: songselect_title
        text: "SONG  SELECT"
        color: "white"
        font.family: font_hemi_head.name
        font.pixelSize: height * 0.8
        style: "Raised"
        styleColor: "#222222"

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: select_bar.top
            top: parent.top
        }
    }

    Item {
        id: select_bar

        width: parent.width
        height: parent.height / 4

        anchors {
            horizontalCenter: parent.horizontalCenter
            topMargin: parent.height / 10
            top: parent.top
        }

        Component {
            id: list_delegate

            Item {
                width: select_bar.width / 5
                height: select_bar.height

                Rectangle {
                    color: "#222222"
                    opacity: 0.7
                    anchors.fill: parent

                    border {
                        color: "transparent"
                        width: 10
                    }

                    gradient: Gradient {
                        orientation: Gradient.Horizontal

                        GradientStop { position: 0.0; color: "transparent" }
                        GradientStop { position: 0.1; color: "#222222" }
                        GradientStop { position: 0.9; color: "#222222" }
                        GradientStop { position: 1.0; color: "transparent" }
                    }
                }

                Image {
                    source: "file:///" + songs_meta[index][0] + "/jacket.png"

                    width: height
                    height: parent.height
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                    opacity: 0.5
                }

                Item {
                    height: parent.height
                    width: height
                    anchors.centerIn: parent
                    Rectangle {
                        anchors.fill: cov
                        color: "#222222"
                        opacity: 0.5
                    }

                    Text {
                        id: cov
                        text: songs_meta[index][2]
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        anchors.centerIn: parent
                        wrapMode: Text.WordWrap
                        width: parent.width
                        font.family: font_Genjyuu_XP_bold.name
                        font.pixelSize: parent.height / 8
                    }
                }
            }
        }

        Component {
            id: list_hl
            Rectangle {
                color: "transparent"
                radius: 10
                z: 3
                border {
                    color: "white"
                    width: 10
                }

            }
        }

        ListView {
            id: select_list
            x: parent.width * 0.4 - currentItem.x

            height: parent.height
            width: select_bar.width / 5 * songs_meta.length
            model: songs_meta
            delegate: list_delegate
            orientation: ListView.Horizontal
            interactive: false

            highlight: list_hl
            highlightMoveDuration: 0

            Behavior on x {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.OutExpo
                }
            }

            onCurrentIndexChanged: {
                dir.stopPreview();
                dir.playEffect();
                player_timer.restart();
            }
        }
    }

    Item {
        property double cont_margin: 60

        id: data_panel
        width: parent.width * 0.8

        anchors {
            top: select_bar.bottom
            topMargin: 50
            bottom: parent.bottom
            bottomMargin: 50
            horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            anchors.fill: parent
            opacity: 0.6

            gradient: Gradient {
                orientation: Gradient.Horizontal

                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.1; color: songs_meta[song_index][5]
                    Behavior on color {
                        ColorAnimation {
                            duration: 250
                        }
                    }
                }
                GradientStop { position: 0.9; color: songs_meta[song_index][5]
                    Behavior on color {
                        ColorAnimation {
                            duration: 250
                        }
                    }
                }
                GradientStop { position: 1.0; color: "transparent" }
            }


        }

        Image {
            id: current_jacket
            fillMode: Image.PreserveAspectFit
            source: "file:///" + songs_meta[song_index][0] + "/jacket.png"

            height: parent.height - 2 * parent.cont_margin
            width: this.height

            anchors {
                top: parent.top
                topMargin: data_panel.cont_margin
                left: parent.left
                leftMargin: data_panel.cont_margin * 2
            }
        }

        Rectangle {
            id: current_bar

            color: "#222222"

            width: 20

            anchors {
                top: current_jacket.top
                bottom: current_artist.bottom
                left: current_jacket.right
                leftMargin: data_panel.cont_margin
            }
        }

        Text {
            id: current_title
            text: songs_meta[song_index][2]
            color: "white"
            font.family: font_Genjyuu_XP_bold.name
            font.pixelSize: height
            minimumPixelSize: 10

            fontSizeMode: Text.Fit
            verticalAlignment: Text.AlignVCenter
            style: "Raised"
            styleColor: "#222222"

            height: current_jacket.height / 6

            anchors {
                top: current_jacket.top
                left: current_bar.right
                leftMargin: data_panel.cont_margin
                right: parent.right
                rightMargin: data_panel.cont_margin * 2
            }
        }

        Text {
            id: current_artist
            text: songs_meta[song_index][1]
            color: "white"
            font.family: font_Genjyuu_XP_bold.name
            font.pixelSize: height
            minimumPixelSize: 10

            fontSizeMode: Text.Fit
            verticalAlignment: Text.AlignVCenter
            style: "Raised"
            styleColor: "#222222"

            height: current_jacket.height / 8

            anchors {
                top: current_title.bottom
                topMargin: 20
                left: current_bar.right
                leftMargin: data_panel.cont_margin
                right: parent.right
                rightMargin: data_panel.cont_margin * 2
            }
        }

        Rectangle {
            color: "white"
            opacity: 0.5

            anchors.fill: difficulty_frame
        }

        Item {
            id: difficulty_frame

            anchors {
                top: current_artist.bottom
                topMargin: 40
                left: current_jacket.right
                leftMargin: data_panel.cont_margin
                bottom: current_jacket.bottom
                right: parent.right
                rightMargin: data_panel.cont_margin * 2
            }

            Column {
                spacing: data_panel.cont_margin
                anchors.centerIn: parent

                Item {
                    id: difficulty_basic
                    width: parent.parent.width
                    height: data_panel.cont_margin

                    Text {
                        text: ">"
                        color: "#222222"
                        font.family: font_hemi_head.name
                        font.pixelSize: parent.height * 0.8
                        visible: !select_expert

                        anchors {
                            left: parent.left
                            leftMargin: 50
                            verticalCenter: parent.verticalCenter
                        }
                    }

                    Rectangle {
                        id: basic_token
                        color: "forestgreen"
                        radius: this.height / 2
                        height: parent.height * 0.75
                        width: parent.width / 3
                        anchors {
                            verticalCenter: parent.verticalCenter
                            right: parent.horizontalCenter
                        }

                        Text {
                            text: "BASIC  " + songs_meta[song_index][6]
                            font.family: font_hemi_head.name
                            color: "white"
                            font.pixelSize: parent.height * 0.8

                            anchors.centerIn: parent
                        }
                    }

                    Text {
                        id: highscore_basic
                        text: "0000000"
                        color: "#222222"
                        font.family: font_hemi_head.name
                        font.pixelSize: parent.height * 0.8

                        anchors {
                            right: parent.right
                            rightMargin: 50
                            verticalCenter: parent.verticalCenter
                        }
                    }
                }

                Item {
                    id: difficulty_expert
                    width: parent.parent.width
                    height: data_panel.cont_margin

                    Text {
                        text: ">"
                        color: "#222222"
                        font.family: font_hemi_head.name
                        font.pixelSize: parent.height * 0.8
                        visible: select_expert

                        anchors {
                            left: parent.left
                            leftMargin: 50
                            verticalCenter: parent.verticalCenter
                        }
                    }

                    Rectangle {
                        id: expert_token
                        color: "firebrick"
                        radius: this.height / 2
                        height: parent.height * 0.75
                        width: parent.width / 3
                        anchors {
                            verticalCenter: parent.verticalCenter
                            right: parent.horizontalCenter
                        }

                        Text {
                            text: "EXPERT  " + songs_meta[song_index][7]
                            font.family: font_hemi_head.name
                            color: "white"
                            font.pixelSize: parent.height * 0.8

                            anchors.centerIn: parent
                        }
                    }

                    Text {
                        id: highscore_expert
                        text: "0000000"
                        color: "#222222"
                        font.family: font_hemi_head.name
                        font.pixelSize: parent.height * 0.8

                        anchors {
                            right: parent.right
                            rightMargin: 50
                            verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
    }

    Timer {
        id: player_timer
        interval: 1500
        repeat: false
        onTriggered: {
            dir.playPreview("file:///" + songs_meta[song_index][0] + "/audio.mp3", songs_meta[song_index][4])
        }
    }

    FontLoader {
        id: font_Genjyuu_XP_bold
        source: "/font/GenJyuuGothicX-P-Bold.ttf"
    }

    FontLoader {
        id: font_hemi_head
        source: "/font/hemi-head-bd-it.ttf"
    }

    function next_song () {
        select_list.incrementCurrentIndex()
    }

    function prev_song () {
        select_list.decrementCurrentIndex()
    }

    function chng_diff () {
        select_expert = !select_expert
    }

    function to_main () {
        pageloader.source = "/ui/option/mainPanel.qml"
    }

    function select() {
        game_transition.state = "LOADING"
        disconnect_all();
        var data = songs_meta[select_list.currentIndex]
        data.push(select_expert)
        game_main.song_data = data;
        destruct.start();
    }

    Component.onCompleted: {
        game_main.rightpress_signal.connect(next_song)
        game_main.leftpress_signal.connect(prev_song)
        game_main.downpress_signal.connect(chng_diff)
        game_main.escpress_signal.connect(to_main)
        game_main.enterpress_signal.connect(select)

        game_transition.state = "COMPLETE"
    }

    function disconnect_all() {
        game_main.rightpress_signal.disconnect(next_song)
        game_main.leftpress_signal.disconnect(prev_song)
        game_main.downpress_signal.disconnect(chng_diff)
        game_main.escpress_signal.disconnect(to_main)
        game_main.enterpress_signal.disconnect(select)
    }

    Component.onDestruction: {
        disconnect_all();
    }

    Timer {
        id: destruct
        interval: game_transition.time
        onTriggered: pageloader.source = "../game/Game.qml"
    }
}
