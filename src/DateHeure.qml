import QtQuick 2.13
import QtQuick.Window 2.13
import QtWebEngine 1.5
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls.Material 2.13
import Qt.labs.folderlistmodel 2.13
import DrivesClass 1.0
import Process 1.0

Label {
    anchors {
        margins: 5
        right: webviewFlash.right
        bottom: webviewFlash.bottom
    }
    font.pixelSize: 12
    horizontalAlignment: Text.AlignRight
    color: "white"
    opacity: 0.40
    visible: dateAndTime
    z: webviewFlash.z + 5

    Timer {
        interval: 500; running: dateAndTime; repeat: true
        onTriggered: parent.text = qsTr(Qt.formatDateTime(new Date(), "dddd dd MMMM yyyy").toUpperCase() + "<br>" + Qt.formatDateTime(new Date(), "hh:mm:ss"))
    }
}
