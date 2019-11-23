var component

function generateNote(gest, bpm, time, left, right) {
    if (component == null)
        component = Qt.createComponent("Click_note.qml");

    if (component.status == Component.Ready) {
        var dynamicObject
        dynamicObject = component.createObject(lane_full)

        if (dynamicObject == null) {
            console.log("err on creating")
            console.log(component.errorString())
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
            dynamicObject.color = "orange"
            break
        }
    }
    else {
        console.log("error loading")
        console.log(component.errorString())
        return false
    }

    return true
}
