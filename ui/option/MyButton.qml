import QtQuick 2.0

Rectangle{
    id:rect
    color: "lightsteelblue";
    height: parent.height/12
    width: parent.width
    radius:10;

    states: [
        State {
            name: "Pressed"
            PropertyChanges {
                target: rect
                color: "red"
            }
        },
        State {
            name: "released"
            PropertyChanges {
                target: rect
                color: "lightsteelblue"
            }
        }
    ]

}
