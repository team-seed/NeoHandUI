import QtQuick 2.12
import QtQuick.Controls 2.12
import QtMultimedia 5.12

Column{
    id: column
    anchors.fill:parent
    Header{ text:"CAMERA TEST" }
    focus: true
    Keys.onPressed: {
        if(event.key == Qt.Key_Left || Qt.Key_Backspace){
            pageloader.source = "mainPanel.qml"
        }
    }

    Camera{
        id: cam
        imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash
        flash.mode: Camera.FlashRedEyeReduction

        exposure {
                    exposureCompensation: -1.0
                    exposureMode: Camera.ExposurePortrait
        }

        imageCapture{
            onImageCaptured: {
                photoPreview.source = preview
            }
        }
    }

    VideoOutput{
        source: cam
        focus: visible
        anchors.horizontalCenter: parent.horizontalCenter
    }
    ListView {
            model: QtMultimedia.availableCameras
            anchors.verticalCenterOffset: 450
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            delegate: Text {
                text: modelData.displayName
                anchors.fill:parent
                color: "white"
                MouseArea {
                    anchors.fill: parent
                    onClicked: cam.deviceId = modelData.deviceId
                }
            }
        }
    Image{ id: photoPreview }


}
