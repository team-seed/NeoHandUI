var note_component
var swipe_component

function generateNote(gest, bpm, time, left, right) {
    if (note_component == null)
        note_component = Qt.createComponent("Click_note.qml");

    if (note_component.status == Component.Ready) {
        var dynamicObject
        dynamicObject = note_component.createObject(lane_full)

        if (dynamicObject == null) {
            console.log("error on creating note")
            console.log(note_component.errorString())
            return false
        }

        dynamicObject.anchors.left = lane_row.left
        dynamicObject.anchors.right = lane_row.right

        dynamicObject.time = time + start_interval + global_offset
        dynamicObject.bpm = bpm
        dynamicObject.anchors.leftMargin = part_width * left
        dynamicObject.anchors.rightMargin = part_width * (16 - right)

        switch (gest) {
        case 0:
            dynamicObject.color = "royalblue"
            break
        case 1:
            dynamicObject.color = "orangered"
            break
        }
    }
    else {
        console.log("error on loading note")
        console.log(note_component.errorString())
        return false
    }

    return true
}

function generateSwipe (dirc, bpm, time, left, right) {
    if (swipe_component == null)
        swipe_component = Qt.createComponent("Swipe_note.qml");

    if (swipe_component.status == Component.Ready) {
        var dynamicObject
        dynamicObject = swipe_component.createObject(lane_full)

        if (dynamicObject == null) {
            console.log("error on creating swipe")
            console.log(swipe_component.errorString())
            return false
        }

        dynamicObject.anchors.left = lane_row.left
        dynamicObject.anchors.right = lane_row.right

        dynamicObject.time = time + start_interval + global_offset
        dynamicObject.bpm = bpm
        dynamicObject.dirc = dirc
        dynamicObject.anchors.leftMargin = part_width * left
        dynamicObject.anchors.rightMargin = part_width * (16 - right)

        //dynamicObject.direction = dirc

        //console.log(dirc)

        switch (dirc) {
        case 0:
            dynamicObject.color = "red"
            break
        case 1:
            dynamicObject.color = "gold"
            break
        case 2:
            dynamicObject.color = "darkorchid"
            break
        case 3:
            dynamicObject.color = "darkseagreen"
            break
        }
    }
    else {
        console.log("error on loading swipe")
        console.log(swipe_component.errorString())
        return false
    }

    return true
}
