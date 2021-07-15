import QtQuick 2.13
import QtQuick.Window 2.13
import QtWebEngine 1.5
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls.Material 2.13
import Qt.labs.folderlistmodel 2.13
import DrivesClass 1.0
import Process 1.0

Item {
    z: 100000

    function ouvrir() {
        infos.width = 260;
        infos.height = 70;
        timerInfos.start();
    }

    function fermer() {
        infos.width = 0;
        infos.height = 0;
        timerInfos.stop();
    }

    Timer {
        id: timerInfos
        interval: 5000
        onTriggered: fermer()
    }

    Rectangle {
        id: infos
        x: 5
        y: window.height - height - 5
        width: 0; height: 0
        gradient: Gradient {
                      GradientStop { position: 0.0; color: "#424242" }
                      GradientStop { position: 1.0; color: "#242424" }
                  }

        border.width: 2
        border.color: "#888"
        visible: width > 0
        clip: true

        Behavior on width { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
        Behavior on height { NumberAnimation { duration: 400; easing.type: Easing.InCirc } }


        RowLayout {
            anchors.fill: parent
            spacing: 5

            ToolButton {
                id: img
                icon.color: sauvegardeCapture ? "grey" : "firebrick"
                icon.source: "qrc:/img/camera.svg"
            }

            Label {
                id: titreTexte
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                font.pixelSize: 14
                text: sauvegardeCapture ? "Capture d'écran réussie !<br>Screenshot successful !" : "La capture d'écran a échoué...<br>Screenshot failed..."
                opacity: 0.8
            }

        } // Fin RowLayout

    } // Fin Rectangle

}
