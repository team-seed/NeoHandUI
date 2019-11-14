import QtQuick 2.12
import QtQuick.Controls 2.12
import QtMultimedia 5.12

Column{
    id: column
    anchors.fill:parent
    Header{ text:"CAMERA TEST" }

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

    Component.onCompleted:{
        game_main.leftpress_signal.connect(tomain)
        game_main.bksppress_signal.connect(tomain)
    }

    function tomain(){pageloader.source = "mainPanel.qml"}

    Component.onDestruction: {
        game_main.leftpress_signal.disconnect(tomain)
        game_main.bksppress_signal.disconnect(tomain)
    }
}
