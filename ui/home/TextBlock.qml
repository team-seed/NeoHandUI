import QtQuick 2.0

Text {
    color: "white"
    style: Text.Raised
    styleColor: "#222222"

    font.family: font_hemi_head.name
    font.pixelSize: height * 0.8

    FontLoader {
        id: font_hemi_head
        source: "/font/hemi-head-bd-it.ttf"
    }
}
