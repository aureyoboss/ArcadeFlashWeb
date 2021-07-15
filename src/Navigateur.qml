import QtQuick 2.13
import QtQuick.Window 2.13
import QtWebEngine 1.5
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls.Material 2.13
import Qt.labs.folderlistmodel 2.13
import DrivesClass 1.0
import Process 1.0

Drawer {
    width: 0.66 * window.width
    height: window.height
    dragMargin: 0

    ListView {
        anchors.fill: parent
        ScrollBar.vertical: ScrollBar { }
        model: folderModel

        header: Rectangle {
            width: parent.width; height: 50
            color: "#607D8B"
            RowLayout {
                anchors {
                    fill: parent
                    leftMargin: 5
                    rightMargin: 5
                }
                spacing: 5

                // Répertoire télécharger
                ToolButton {
                    icon.color: "#2c3940"
                    icon.source: "qrc:/img/folder-download.svg"
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignLeft
                    onClicked: folderModel.folder = "file:///" + downloadPath

                    ToolTip {
                        visible: parent.hovered || parent.pressed
                        text: qsTr("Ouvrir le répertoire « <b>Téléchargements</b> ».<br>Open « <b>Download</b> » folder.")
                        y: parent.height
                    }
                }

                // Répertoire Mes Documents
                ToolButton {
                    icon.color: "#2c3940"
                    icon.source: "qrc:/img/folder-mydocuments.svg"
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignLeft
                    onClicked: folderModel.folder = "file:///" + documentPath

                    ToolTip {
                        visible: parent.hovered || parent.pressed
                        text: qsTr("Ouvrir le répertoire « <b>Mes Documents</b> ».<br>Open « <b>My Documents</b> » folder.")
                        y: parent.height
                    }
                }

                // Répertoire Bureau
                ToolButton {
                    icon.color: "#2c3940"
                    icon.source: "qrc:/img/folder-desktop.svg"
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignLeft
                    onClicked: folderModel.folder = "file:///" + deskPath

                    ToolTip {
                        visible: parent.hovered || parent.pressed
                        text: qsTr("Ouvrir le répertoire « <b>Bureau</b> ».<br>Open « <b>Desktop</b> » folder.")
                        y: parent.height
                    }
                }

                // Répertoire Utilisateur
                ToolButton {
                    icon.color: "#2c3940"
                    icon.source: "qrc:/img/folder-user.svg"
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignLeft
                    onClicked: folderModel.folder = "file:///" + homePath

                    ToolTip {
                        visible: parent.hovered || parent.pressed
                        text: qsTr("Ouvrir le répertoire « <b>Utilisateur</b> ».<br>Open « <b>User</b> » folder.")
                        y: parent.height
                    }
                }

                Item { Layout.fillWidth: true }

                ComboBox {
                    id: listeDesLecteurs
                    currentIndex: lettreLecteurNbr
                    model: drives
                    onActivated: folderModel.folder = "file:///" + drives[currentIndex]
                }


            } // Fin RowLayout


        }

        FolderListModel {
            id: folderModel
            caseSensitive: false
            showDirsFirst: true
            folder: adresseDuNavigateur
            sortField: FolderListModel.Name
            showDotAndDotDot: true
            nameFilters: ["*.swf", "*.SWF"]
            onFolderChanged: adresseDuNavigateur = folder
        }

        delegate: ItemDelegate {
                    width: parent.width

                    Rectangle {
                        anchors.fill: parent
                        color: fileIsDir ? index%2 === 0 ? "#607D8B" : Qt.tint("#607D8B", "#30000000") : index%2 === 0 ? "gray" : Qt.tint("gray", "#30000000")
                        opacity: 0.5
                        Behavior on color { ColorAnimation { duration: 500 } }

                        Label {
                            anchors.centerIn: parent
                            text: fileIsDir ? qsTr(fileName.toUpperCase()) : qsTr(fileName)
                            font.bold: true
                            font.pixelSize: 18
                        }

                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {

                            if (fileIsDir) {
                                folderModel.folder = fileURL;
                            }

                            if (!fileIsDir) {
                                source = filePath;

                                process1.execute("cmd.exe", ["/C", applicationDirPath + "/swfdump.exe", "-X", "-Y", source, ">", dataPath[0] + "/swf.txt"]);
                                readTextFile("file:///" + dataPath[0] + "/swf.txt");

                                webviewFlash.url = "file:///" + applicationDirPath + "/flash/flash.html?jeu=" + source + "=" + swfwidth + "=" + swfheight;

                                isSWF = true;

                                drawerFlash.close();
                            }
                        }
                    }

                } // Fin ItemDelegate

    } // Fin ListView

} // Fin Drawer
