import QtQuick 2.13
import QtQuick.Window 2.13
import QtWebEngine 1.5
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls.Material 2.13
import Qt.labs.folderlistmodel 2.13
import DrivesClass 1.0
import Process 1.0

Rectangle {
    color: "transparent"

    Behavior on opacity { NumberAnimation { duration: 500 } }

    RowLayout {
        anchors.fill: parent

        // Ouvrir un fichier SWF
        ToolButton {
            icon.color: "grey"
            icon.source: "qrc:/img/swf-file.svg"
            onClicked: drawerFlash.open()

            ToolTip {
                visible: parent.hovered || parent.pressed
                text: qsTr("Ouvrir un fichier SWF.<br>Open a SWF file.")
                y: parent.height
            }
        }

        //Ouvrir un lien internet
        ToolButton {
            icon.color: "grey"
            icon.source: "qrc:/img/internet.svg"
            onClicked: internetAdresseDialog.open()

            ToolTip {
                visible: parent.hovered || parent.pressed
                text: qsTr("Ouvrir une adresse internet (Flash).<br>Open an internet address (Flash).")
                y: parent.height
            }
        }

        // Titre du logiciel
        Label {
            id: titreLogiciel
            text: qsTr("ArcadeFlashWeb")
            font.pixelSize: 18
            font.bold: true
            elide: Label.ElideRight
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            Layout.fillWidth: true
            color: "transparent"
        }

        // À propos
        ToolButton {
            icon.color: "grey"
            icon.source: "qrc:/img/about.svg"
            onClicked: aProposDialog.open()

            ToolTip {
                visible: parent.hovered || parent.pressed
                text: qsTr("À propos.<br>About.")
                y: parent.height
            }
        }

        // Configurer le type d'écean
        ToolButton {
            enabled: isSWF
            icon.color: enabled ? "grey" : "firebrick"
            icon.source: "qrc:/img/layers.svg"
            onClicked: {
                bezelActif =! bezelActif;
                bezelActifOrigine = bezelActif;
            }

            Rectangle {
                anchors {
                    right: parent.right
                    bottom: parent.bottom
                    bottomMargin: 5
                }
                color: Qt.darker("#2c3940")
                width: 20; height: width
                radius: width
                opacity: 0.8
                visible: !bezelActif
                z: parent.z + 10

                Label {
                    anchors.centerIn: parent
                    text: "X"
                    font.pixelSize: 8
                }
            }

            ToolTip {
                visible: parent.hovered || parent.pressed
                text: qsTr("Activer/désactiver la décoration (cela désactive aussi le CRT/SCANLINES).<br>Enable/disable bezel (this also disables CRT/SCANLINES).")
                y: parent.height
            }
        }

        // Configurer le type d'écean
        ToolButton {
            enabled: isSWF
            icon.color: enabled ? "grey" : "firebrick"
            icon.source: "qrc:/img/screen_mod.svg"
            onClicked: {
                modeEcran += 1;

                if (modeEcran === 0) {
                    screenEmulationSource = "";
                } else if (modeEcran === 1) {
                    screenEmulationSource = "qrc:/img/crt.png";
                } else if (modeEcran === 2) {
                    screenEmulationSource = "qrc:/img/scanlines.png";
                } else {
                    screenEmulationSource = "";
                }

                if (modeEcran > 2) modeEcran = 0;
            }

            Rectangle {
                anchors {
                    right: parent.right
                    bottom: parent.bottom
                    bottomMargin: 5
                }
                color: Qt.darker("#2c3940")
                width: 20; height: width
                radius: width
                opacity: 0.8
                z: parent.z + 10
                Label {
                    anchors {
                        centerIn: parent
                    }
                    text: {
                        if (modeEcran === 0) {
                            "X"
                        } else if (modeEcran === 1) {
                            "CRT"
                        } else if (modeEcran === 2) {
                            "SCNL"
                        } else {
                            ""
                        }
                    }
                    font.pixelSize: 8
                }
            }

            ToolTip {
                visible: parent.hovered || parent.pressed
                text: qsTr("Changer le mode d'écran (CRT, Scanlines) - cliquez plusieurs fois.<br>Change screen mode (CRT, Scanlines) - click several times.")
                y: parent.height
            }
        }

        // Activer/désactiver la date et l'heure
        ToolButton {
            icon.color: dateAndTime ? "grey" : "firebrick"
            icon.source: "qrc:/img/date-time.svg"
            onClicked: dateAndTime =! dateAndTime;

            ToolTip {
                visible: parent.hovered || parent.pressed
                text: qsTr("Activer/désactiver la date et l'heure.<br>Enable/disable date and time.")
                y: parent.height
            }
        }

        // Capture d'écran
        ToolButton {
            enabled: isSWF
            icon.color: enabled ? "grey" : "firebrick"
            icon.source: "qrc:/img/camera.svg"
            onClicked: capture()

            ToolTip {
                visible: parent.hovered || parent.pressed
                text: qsTr("Capture d'écran (vers le répertoire « <i>Images</i> »).<br>Screenshot (to « <i>Pictures</i> » folder).")
                y: parent.height
            }
        }

        // Mettre en plein écran et cacher le menu
        ToolButton {
            icon.color: "grey"
            icon.source: "qrc:/img/full-screen.svg"
            onClicked: {
                header.height = 0;
                header.opacity = 0.0;
            }

            ToolTip {
                visible: parent.hovered || parent.pressed
                text: qsTr("Plein écran.<br>Full screen.")
                y: parent.height
            }
        }

        // Réduire
        ToolButton {
            icon.color: "grey"
            icon.source: "qrc:/img/minimize.svg"
            onClicked: window.showMinimized()

            ToolTip {
                visible: parent.hovered || parent.pressed
                text: qsTr("Réduire.<br>Minimize.")
                y: parent.height
            }
        }

        // Quitter
        ToolButton {
            icon.color: "grey"
            icon.source: "qrc:/img/close.svg"
            onClicked: quitterAFWDialog.open()

            ToolTip {
                visible: parent.hovered || parent.pressed
                text: qsTr("Quitter.<br>Quit.")
                y: parent.height
            }
        }

    } // Fin RowLayout

 } // Fin Rectangle Header


