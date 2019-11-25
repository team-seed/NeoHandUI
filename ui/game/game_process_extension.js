var note_component
var swipe_component
var barline_component
var hold_component

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
        dynamicObject.gesture = gest
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

        dynamicObject.pos = part_width * (8-left)

        switch (dirc) {
        case 0:
            dynamicObject.color = "red"
            dynamicObject.arrow_angle = -90
            break
        case 1:
            dynamicObject.color = "gold"
            dynamicObject.arrow_angle = 90
            break
        case 2:
            dynamicObject.color = "darkorchid"
            dynamicObject.arrow_angle = 180
            break
        case 3:
            dynamicObject.color = "darkseagreen"
            dynamicObject.arrow_angle = 0
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

function generateBarline (bpm, time) {
    if (barline_component == null)
        barline_component = Qt.createComponent("Barline.qml");

    if (barline_component.status == Component.Ready) {
        var dynamicObject
        dynamicObject = barline_component.createObject(lane_full)

        if (dynamicObject == null) {
            console.log("error on creating swipe")
            console.log(barline_component.errorString())
            return false
        }

        dynamicObject.anchors.left = lane_row.left
        dynamicObject.anchors.right = lane_row.right

        dynamicObject.time = time + start_interval + global_offset
        dynamicObject.bpm = bpm
    }
    else {
        console.log("error on loading swipe")
        console.log(barline_component.errorString())
        return false
    }

    return true
}

function generateHold(gest, bpm, s_time, s_left, s_right, e_time, e_left, e_right) {
    if (hold_component == null)
        hold_component = Qt.createComponent("Hold_note.qml");

    if (hold_component.status == Component.Ready) {
        var dynamicObject
        dynamicObject = hold_component.createObject(lane_full)

        if (dynamicObject == null) {
            console.log("error on creating note")
            console.log(hold_component.errorString())
            return false
        }

        dynamicObject.anchors.left = lane_row.left
        //dynamicObject.anchors.right = lane_row.right

        dynamicObject.start_time = s_time + start_interval + global_offset
        dynamicObject.end_time = e_time + start_interval + global_offset

        dynamicObject.bpm = bpm
        dynamicObject.gesture = gest
        dynamicObject.anchors.leftMargin = part_width * e_left

        dynamicObject.right_top = part_width * (e_right - e_left)
        dynamicObject.right_bottom = part_width * (s_right - e_left)
        dynamicObject.left_bottom = part_width * (s_left - e_left)
        //dynamicObject.anchors.rightMargin = part_width * (16 - right)

        switch (gest) {
        case 0:
            dynamicObject.shape_color = "royalblue"
            break
        case 1:
            dynamicObject.shape_color = "orangered"
            break
        }
    }
    else {
        console.log("error on loading note")
        console.log(hold_component.errorString())
        return false
    }

    return true
}
