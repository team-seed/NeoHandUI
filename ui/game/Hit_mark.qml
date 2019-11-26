import QtQuick 2.12

Image {
    property int y_offset: 0

    id: mark_image

    height: 30
    fillMode: Image.PreserveAspectFit
    opacity: 0.75
    y: judge_line.y

    SequentialAnimation {
        running: true
        NumberAnimation {
            target: mark_image
            property: "y"
            to: judge_line.y - 50
            easing.type: Easing.OutExpo
            duration: 200
        }
        NumberAnimation {
            target: mark_image
            property: "opacity"
            to: 0
            duration: 200
            //easing.type: Easing.OutExpo
        }
        onRunningChanged: {
            if (!running) {
                console.log("destroyed")
                mark_image.destroy()
            }
        }
    }
}


