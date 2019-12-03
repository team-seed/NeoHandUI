import QtQuick 2.12

import "../game/game_extension.js" as EXT

Item {
    id: result_container
    anchors.fill: parent

    property string rank: "F"

    Image {
        id: result_background
        opacity: 0.5
        source: "file:///" + game_main.song_data[0] + "/bg.png"

        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
    }

    Item {
        property double cont_margin: parent.width / 32

        id: data_panel
        width: parent.width * 0.8

        anchors {
            top: parent.top
            topMargin: 50
            bottom: result_detail.top
            bottomMargin: 50
            horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            anchors.fill: parent
            opacity: 0.6

            gradient: Gradient {
                orientation: Gradient.Horizontal

                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.1; color: "black" }
                GradientStop { position: 0.9; color: "black" }
                GradientStop { position: 1.0; color: "transparent" }
            }
        }

        Image {
            id: current_jacket
            fillMode: Image.PreserveAspectFit
            source: "file:///" + game_main.song_data[0] + "/jacket.png"

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
            text: game_main.song_data[2]
            color: "white"
            font.family: font_Genjyuu_XP_bold.name
            font.pixelSize: height
            minimumPixelSize: 10

            fontSizeMode: Text.Fit
            verticalAlignment: Text.AlignVCenter
            style: Text.Raised
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
            text: game_main.song_data[1]
            color: "white"
            font.family: font_Genjyuu_XP_bold.name
            font.pixelSize: height
            minimumPixelSize: 10

            fontSizeMode: Text.Fit
            verticalAlignment: Text.AlignVCenter
            style: Text.Raised
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
            id: difficulty_token
            height: current_artist.height
            width: height * 8
            radius: height / 2

            anchors {
                left: current_jacket.right
                leftMargin: data_panel.cont_margin
                top: current_bar.bottom
                topMargin: data_panel.cont_margin
            }

            color: game_main.song_data[8] ? "firebrick" : "forestgreen"

            TextBlock {
                id: difficulty_name
                text: game_main.song_data[8] ? ("EXPERT  " + game_main.song_data[7]) : ("BASIC  " + game_main.song_data[6])
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        TextBlock {
            id: score_display
            text: final_score.numberFormat(0, '', ',')

            anchors {
                top: difficulty_token.bottom
                topMargin: data_panel.cont_margin
                bottom: parent.bottom
                bottomMargin: data_panel.cont_margin
                left: current_jacket.right
                leftMargin: data_panel.cont_margin
            }
        }

        TextBlock {
            id: rank_display
            text: rank

            anchors {
                top: difficulty_token.top
                bottom: score_display.bottom
                right: parent.right
                rightMargin: data_panel.cont_margin * 2.5
            }
        }
    }

    Item {
        id: result_detail
        property double result_margin: parent.height / 32

        height: parent.height / 3
        width: data_panel.width

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 50
        }

        Rectangle {
            anchors.fill: parent
            opacity: 0.6

            gradient: Gradient {
                orientation: Gradient.Horizontal

                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.1; color: "black" }
                GradientStop { position: 0.9; color: "black" }
                GradientStop { position: 1.0; color: "transparent" }
            }
        }

        Item {
            width: parent.width / 2
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: result_detail.result_margin
                bottom: parent.bottom
                bottomMargin: result_detail.result_margin
            }

            Column {
                id: note_count_container
                spacing: 0
                height: parent.height
                width: parent.width / 2

                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }

                Item {
                    id: total_count
                    anchors.left: parent.left
                    height: note_count_container.height / 4
                    width: parent.width

                    TextBlock { text: "TOTAL"; height: parent.height; anchors.left: parent.left; anchors.leftMargin: 15 }
                    Rectangle { color: "black"; anchors.fill: parent; opacity: 0.5 }
                    TextBlock { text: result_data[0].toString(); height: parent.height; anchors.right: parent.right; anchors.rightMargin: 15 }
                }

                Item {
                    id: exact_count
                    anchors.left: parent.left
                    height: note_count_container.height / 4
                    width: parent.width

                    TextBlock { text: "EXACT"; height: parent.height; anchors.left: parent.left; anchors.leftMargin: 15 }
                    Rectangle { color: "gold"; anchors.fill: parent; opacity: 0.5 }
                    TextBlock { text: result_data[1].toString(); height: parent.height; anchors.right: parent.right; anchors.rightMargin: 15 }
                }

                Item {
                    id: close_count
                    anchors.left: parent.left
                    height: note_count_container.height / 4
                    width: parent.width

                    TextBlock { text: "CLOSE"; height: parent.height; anchors.left: parent.left; anchors.leftMargin: 15 }
                    Rectangle { color: "skyblue"; anchors.fill: parent; opacity: 0.5 }
                    TextBlock { text: result_data[2].toString(); height: parent.height; anchors.right: parent.right; anchors.rightMargin: 15 }
                }

                Item {
                    id: break_count
                    anchors.left: parent.left
                    height: note_count_container.height / 4
                    width: parent.width

                    TextBlock { text: "BREAK"; height: parent.height; anchors.left: parent.left; anchors.leftMargin: 15 }
                    Rectangle { color: "red"; anchors.fill: parent; opacity: 0.5 }
                    TextBlock { text: result_data[3].toString(); height: parent.height; anchors.right: parent.right; anchors.rightMargin: 15 }
                }
            }

            Item {
                id: accuracy_container
                height: parent.height
                width: parent.width / 2

                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }

                Item {
                    width: parent.width
                    height: parent.height / 2

                    anchors {
                        top: parent.top
                        horizontalCenter: parent.horizontalCenter
                    }

                    TextBlock {
                        text: "ACCURACY"
                        height: 30
                        anchors {
                            top: parent.top
                            topMargin: 8
                            leftMargin: 8
                            left: parent.left
                        }
                    }

                    Rectangle {
                        color: "gray"
                        anchors.fill: parent
                        opacity: 0.5
                    }

                    TextBlock {
                        text: result_data[4].toFixed(2).toString() + " %"
                        anchors.centerIn: parent
                        height: parent.height / 2
                    }
                }

                Item {
                    width: parent.width
                    height: parent.height / 2

                    anchors {
                        bottom: parent.bottom
                        horizontalCenter: parent.horizontalCenter
                    }

                    TextBlock {
                        text: "MAX COMBO"
                        height: 30
                        anchors {
                            top: parent.top
                            topMargin: 8
                            leftMargin: 8
                            left: parent.left
                        }
                    }

                    Rectangle {
                        color: "deepskyblue"
                        anchors.fill: parent
                        opacity: 0.5
                    }

                    TextBlock {
                        text: result_data[5].toString()
                        anchors.centerIn: parent
                        height: parent.height / 2
                    }
                }
            }
        }
    }

    function return_home () {
        disconnect_all()
        game_transition.state = "LOADING"
        destruct.start()
    }

    function to_main () {
        pageloader.source = "/ui/option/mainPanel.qml"
    }

    function disconnect_all() {
        game_main.enterpress_signal.disconnect(return_home)
        game_main.escpress_signal.disconnect(to_main)
    }

    Component.onCompleted: {
        if (final_score == 1000000) { rank = "PF" }
        else if (final_score >= 900000) { rank = "EX" }
        else if (final_score >= 800000) { rank = "S" }
        else if (final_score >= 700000) { rank = "A" }
        else if (final_score >= 600000) { rank = "B" }
        else if (final_score >= 500000) { rank = "C" }
        else if (final_score >= 400000) { rank = "D" }
        else { rank = "F" }

        game_main.enterpress_signal.connect(return_home)
        game_main.escpress_signal.connect(to_main)
        game_transition.state = "COMPLETE"
    }

    Component.onDestruction: {
        disconnect_all()
    }

    Timer {
        id: destruct
        interval: game_transition.time
        onTriggered: pageloader.source = "/ui/home/Home.qml"
    }

    FontLoader {
        id: font_Genjyuu_XP_bold
        source: "/font/GenJyuuGothicX-P-Bold.ttf"
    }

    FontLoader {
        id: font_hemi_head
        source: "/font/hemi-head-bd-it.ttf"
    }

}
