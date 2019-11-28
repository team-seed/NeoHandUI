var note_component
var swipe_component
var barline_component
var hold_component
var mark_component

function generateNote(gest, bpm, time, left, right) {
    if (note_component == null)
        note_component = Qt.createComponent("Click_note.qml");

    if (note_component.status == Component.Ready) {
        var dynamicObject
        dynamicObject = note_component.createObject(hold_note_container)

        if (dynamicObject == null) {
            console.log("error on creating note")
            console.log(note_component.errorString())
            return false
        }

        dynamicObject.anchors.left = hold_note_container.left
        dynamicObject.anchors.right = hold_note_container.right

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
            dynamicObject.color = "deepskyblue"
            dynamicObject.arrow_angle = 180
            break
        case 3:
            dynamicObject.color = "limegreen"
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
        dynamicObject = barline_component.createObject(hold_note_container)

        if (dynamicObject == null) {
            console.log("error on creating swipe")
            console.log(barline_component.errorString())
            return false
        }

        dynamicObject.anchors.left = hold_note_container.left
        dynamicObject.anchors.right = hold_note_container.right

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
        dynamicObject = hold_component.createObject(hold_note_container)

        if (dynamicObject == null) {
            console.log("error on creating note")
            console.log(hold_component.errorString())
            return false
        }

        dynamicObject.anchors.left = hold_note_container.left
        //dynamicObject.anchors.right = lane_row.right

        dynamicObject.start_time = s_time + start_interval + global_offset
        dynamicObject.end_time = e_time + start_interval + global_offset

        dynamicObject.bpm = bpm
        dynamicObject.gesture = gest

        var leftpoint = Math.min(e_left, s_left)

        dynamicObject.anchors.leftMargin = part_width * leftpoint

        dynamicObject.left_top = part_width * (e_left - leftpoint)
        dynamicObject.left_bottom = part_width * (s_left - leftpoint)
        dynamicObject.right_top = part_width * (e_right - leftpoint)
        dynamicObject.right_bottom = part_width * (s_right - leftpoint)

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

function generateHitMark (type, timing) {
    if (mark_component == null)
        mark_component = Qt.createComponent("Hit_mark.qml");

    if (mark_component.status == Component.Ready) {
        var dynamicObject
        dynamicObject = mark_component.createObject(lane_full)

        if (dynamicObject == null) {
            console.log("error on creating mark")
            console.log(mark_component.errorString())
            return false
        }

        switch (type) {
        case 0:
            if (timing < 50) {
                dynamicObject.src = "qrc:/images/exact.png"
                game_core.add_combo()
                life.gain_health()
            }
            else if (timing < 120) {
                dynamicObject.src = "qrc:/images/close.png"
                game_core.add_combo()
            }
            else {
                dynamicObject.src = "qrc:/images/break.png"
                game_core.break_combo()
                life.lose_health()
            }
            break
        case 1:
            if (timing < 120) {
                dynamicObject.src = "qrc:/images/exact.png"
                game_core.add_combo()
                life.gain_health()
            }
            else {
                dynamicObject.src = "qrc:/images/break.png"
                game_core.break_combo()
                life.lose_health()
            }
            break
        }

        dynamicObject.destroy(1000)
    }
    else {
        console.log("error on loading mark")
        console.log(mark_component.errorString())
        return false
    }

    return true
}
