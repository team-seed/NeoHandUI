import QtQuick 2.0

Rectangle{
    id: rect
    color: "lightsteelblue";
    width:175;
    height: 25;
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
