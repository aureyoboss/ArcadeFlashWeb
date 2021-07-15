import QtQuick 2.13
import QtQuick.Window 2.13
import QtWebEngine 1.5
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls.Material 2.13
import QtQuick.LocalStorage 2.13
import Qt.labs.folderlistmodel 2.13
import DrivesClass 1.0
import Process 1.0

import "Sauvegarde.js" as Storage

ApplicationWindow {
    id: window
    width: 800
    height: 600
    visible: true
    visibility: Window.FullScreen
    color: "black"
    title: qsTr("ArcadeFlashWeb (AureyoBoss)")
    onClosing: {
        Storage.setConfig(adresseDuNavigateur, bezelActif, modeEcran, dateAndTime);
        Qt.quit();
    }
    onActiveChanged: {
        if (window.active) {
            window.visibility = Window.FullScreen;
            window.showFullScreen();
        }
    }

    // Les variables
    property string version: "1.0.2"
    property string build: "11/04/2021"
    property string letterLoad: ""
    property string source: ""
    property string swfwidth: ""
    property string swfheight: ""
    property string savedataflash: ""
    property string folderPictures: ""
    property string profilantimicro: ""
    property string controleurantimicro: ""
    property string screentype: ""
    property string screenEmulationSource: ""
    property string adresseEnCoursUrl: ""
    property string adresseDuNavigateur: ""

    property variant informations_dimen_jeu: []
    property variant informations_parametres: []

    property bool isSWF: false
    property bool dateAndTime: true
    property bool bezelActif: true
    property bool bezelActifOrigine: true
    property bool sauvegardeCapture: true

    property int modeEcran: 0
    property int lettreLecteurNbr: 0

    property real widthJeu
    property real heightJeu

    property var drives: aDrive.drives

    // Couleur du thème
    Material.theme: Material.Dark
    Material.accent: Material.BlueGrey
    Material.primary: Material.BlueGrey


    // Entête du logiciel
    Header {
        id: header
        x: 0; y: 0
        width: parent.width; height: 48
        opacity: 1.0
        visible: opacity > 0.0
        z: 999
    }

    // Navigateur de fichiers
    Navigateur { id: drawerFlash }

    // Informations
    Infos { id: media }

    //Afficher l'heure
    DateHeure { id: tempsHeure }

    // Raccourcis Quitter
    Shortcut { sequence: "ESC"; onActivated: quitterAFWDialog.open() }

    // Raccourcis capture d'écran
    Shortcut { enabled: isSWF
        sequence: "Ctrl+S"
        onActivated: capture()
    }

    // Obtenir la liste des lecteurs
    DrivesClass { id: aDrive }

    // Pour exécuter des logiciels externes avec arguments
    Process { id: process0 }
    Process { id: process1 }


    // Pour lire le contenu du fichier TXT (width et height natifs des SWF)
    function readTextFile(file)
    {
        var rawFile = new XMLHttpRequest();
        rawFile.open("GET", file, false);
        rawFile.onreadystatechange = function ()
        {
            if(rawFile.readyState === 4)
            {
                if(rawFile.status === 200 || rawFile.status === 0)
                {
                    informations_dimen_jeu = "";
                    var allText = rawFile.responseText;
                    informations_dimen_jeu = allText.split(" ");
                    swfwidth = parseInt(informations_dimen_jeu[1]);
                    swfheight = parseInt(informations_dimen_jeu[3]);
                }
            }
        }
        rawFile.send("");
    }


    // Pour capturer le jeu
    function capture() {
        calculerLaPositionJeu();

        cadrageCapture.grabToImage(function(result) {

            var filename = source.replace(/^.*[\\\/]/, '');

            if (folderPictures.length > 0) {

                if (result.saveToFile(folderPictures + "/" + filename.replace(".swf", "") + ".jpg") === true) {
                    sauvegardeCapture = true;
                } else {
                    sauvegardeCapture = false;
                }

            } else {

                if (result.saveToFile(imagePath + "/" + filename.replace(".swf", "") + ".jpg") === true) {
                    sauvegardeCapture = true;
                } else {
                    sauvegardeCapture = false;
                }
            }

        });

        media.ouvrir();
    }


    ///////////////////////////////////////////////////////////////////////////
    // À charger au démarrage
    ///////////////////////////////////////////////////////////////////////////
    Component.onCompleted: {

        // Initialisation de la base de données et des variables
        Storage.initialize();

        if (Storage.getConfig()[0].length === 0) {

            Storage.setConfig("file:///" + applicationDirPath, true, 0, true);

            adresseDuNavigateur = "file:///" + applicationDirPath;
            bezelActif = true;
            bezelActifOrigine = true;
            modeEcran = 0;
            dateAndTime= true;

        } else {

            informations_parametres = Storage.getConfig();

            adresseDuNavigateur = informations_parametres[0].toString();

            modeEcran = informations_parametres[2].toString();
            if (modeEcran === 0) {
                screenEmulationSource = "";
            } else if (modeEcran === 1) {
                screenEmulationSource = "qrc:/img/crt.png";
            } else if (modeEcran === 2) {
                screenEmulationSource = "qrc:/img/scanlines.png";
            } else {
                screenEmulationSource = "";
            }

            if (informations_parametres[1] == 1) {
                bezelActif = true;
                bezelActifOrigine = true;
            } else {
                bezelActif = false;
                bezelActifOrigine = false;
            }

            if (informations_parametres[3] == 1) {
                dateAndTime = true;
            } else {
                dateAndTime = false;
            }

        }
        //console.log(adresseDuNavigateur + " | " + bezelActif + " | " + modeEcran + " | " + dateAndTime);


        // Récupérer la lettre du lecteur actuel
        letterLoad = adresseDuNavigateur.toLowerCase().substring(8, 11);
        for (var i = 0; i < drives.length; i++) {
            if (drives[i].toLowerCase().search(letterLoad) !== -1) lettreLecteurNbr = i;
        }


        // Intégration des lignes de commande
        for (const element of commandLine) {

            if (element.indexOf("-source:") !== -1)
            {
                var decoupageSource = element.replace("-source:", "");
                source = decoupageSource.split('\\').join('/');
            }

            else if (element.indexOf("-swfwidth:") !== -1)
            {
                swfwidth = element.replace("-swfwidth:", "");
            }

            else if (element.indexOf("-swfheight:") !== -1) {
                swfheight = element.replace("-swfheight:", "");
            }

            else if (element.indexOf("-savedataflash:") !== -1)
            {
                var decoupageSaveData = element.replace("-savedataflash:", "");
                savedataflash = decoupageSaveData.split('\\').join('/');
            }

            else if (element.indexOf("-profilantimicro:") !== -1)
            {
                profilantimicro = element.replace("-profilantimicro:", "");
            }

            else if (element.indexOf("-controleurantimicro:") !== -1)
            {
                controleurantimicro = element.replace("-controleurantimicro:", "");
            }

            else if (element.indexOf("-screentype:") !== -1)
            {
                screentype = element.replace("-screentype:", "");
            }

            else if (element.indexOf("-fullscreen") !== -1)
            {
                header.height = 0;
                header.opacity = 0.0;
            }

            else if (element.indexOf("-nodatetime") !== -1)
            {
                dateAndTime = false;
            }

            else if (element.indexOf("-help") !== -1 || element.indexOf("-?") !== -1)
            {
                aideDialog.open();
            }

            else if (element.indexOf("-picturesfolder:") !== -1)
            {
                var decoupagePicturesFolder = element.replace("-picturesfolder:", "");
                folderPictures = decoupagePicturesFolder.split('\\').join('/');
            }

        }

        //console.log("Ligne de commande : " + source + " | " + swfwidth + " | " + swfheight + " | " + savedataflash + " | " + profilantimicro + " | " + controleurantimicro + " | " + screentype);
        //console.log("Ligne de commande (longueur) : " + source.length);

        // Vérifier la présence d'argument pour le type d'écran
        if (screentype.length > 0) {

            if (screentype === "crt") {
                screenEmulationSource = "qrc:/img/crt.png";
                modeEcran = 1;
            } else if (screentype === "scanlines") {
                modeEcran = 2;
                screenEmulationSource = "qrc:/img/scanlines.png";
            }

        }

        // Vérifier la présence d'argument pour la source locale ou internet
        if (source.length > 0) {

            // Vérifier la présence d'arguments pour AntiMicro
            if (profilantimicro.length > 0) {

                if (controleurantimicro.length > 0) {
                    //process0.start(applicationDirPath + "/antimicro/antimicro.exe", ["--hidden", "--profile", applicationDirPath + "/antimicro/profiles/" + profilantimicro, "--profile-controller", controleurantimicro]);
                    process0.start(applicationDirPath + "/antimicro/antimicro.exe", ["--hidden", "--profile-controller", controleurantimicro]);
                } else {
                    process0.start(applicationDirPath + "/antimicro/antimicro.exe", ["--hidden", "--profile", applicationDirPath + "/antimicro/profiles/" + profilantimicro]);
                }

            }

            // Vérifier la présence d'arguments pour lancer le jeu ou l'adresse web
            if (source.search("http") === -1) {

                if (maintenance.verifyFile(source)) {

                    if (swfwidth.length === 0 || swfheight.length === 0)
                    {

                        process1.execute("cmd.exe", ["/C", applicationDirPath + "/swfdump.exe", "-X", "-Y", source, ">", dataPath[0] + "/swf.txt"]);
                        readTextFile("file:///" + dataPath[0] + "/swf.txt");

                        webviewFlash.url = "file:///" + applicationDirPath + "/flash/flash.html?jeu=" + source + "=" + swfwidth + "=" + swfheight;
                        //console.log("Lancement en ligne de commande : " + applicationDirPath + " | " + source + " | " + swfwidth + " | " + swfheight);

                    }

                    else
                    {
                        webviewFlash.url = "file:///" + applicationDirPath + "/flash/flash.html?jeu=" + source + "=" + swfwidth + "=" + swfheight;
                    }

                    isSWF = true;

                } else {
                    pasSWFDialog.open();
                    isSWF = false;
                }

            } else {
                webviewFlash.url = source;
                isSWF = false;
            }

        }

    }



    ///////////////////////////////////////////////////////////////////////////
    // Quitter le plein écran et réafficher le menu
    ///////////////////////////////////////////////////////////////////////////
    Button {
        anchors {
            right: parent.right
            top: header.bottom
            margins: 10
        }
        icon.color: "grey"
        icon.source: "qrc:/img/exit-full-screen.svg"
        flat: true
        opacity: header.visible ? 0.0 : 0.8
        visible: opacity > 0.0
        onClicked: {
            header.height = 48;
            header.opacity = 1.0;
        }
        Behavior on opacity { NumberAnimation { duration: 500 } }

        ToolTip {
            visible: parent.hovered || parent.pressed
            text: qsTr("Quitter le plein écran.<br>Quit full screen.")
            y: parent.height
        }

        z: webviewFlash.z + 8
    }



    ///////////////////////////////////////////////////////////////////////////
    // Ajouter un curseur sous la souris (point rouge)
    ///////////////////////////////////////////////////////////////////////////
    MouseArea {
        id: mouseAreaPerso
        anchors.fill: parent
        preventStealing: true
        hoverEnabled: true
        propagateComposedEvents: true
        z: header.z - 1

        onPressAndHold: { mouse.accepted = false }
        onPressed: { mouse.accepted = false }
        onReleased: { mouse.accepted = false }
        onClicked: { mouse.accepted = false }
        onDoubleClicked: { mouse.accepted = false }
        onPositionChanged: {
            cursorPerso.x = mouseX - (cursorPerso.width/2);
            cursorPerso.y = mouseY - (cursorPerso.width/2);
            mouse.accepted = false;
        }

    }
    Rectangle {
        id: cursorPerso
        width: 8; height: width
        color: "red"
        radius: width
        opacity: 0.4
        z: mouseAreaPerso.z + 10
    }



    ///////////////////////////////////////////////////////////////////////////
    // Images diverses (CRT, SCANLINES, fond, Bezel)
    ///////////////////////////////////////////////////////////////////////////
    // CRT et SCANLINES
    Image {
        anchors.fill: screenBezel//parent
        antialiasing: true
        smooth: true
        mipmap: true
        fillMode: modeEcran === 1 ? Image.TileVertically : Image.TileHorizontally
        verticalAlignment: Image.AlignLeft
        opacity: 0.8
        source: screenEmulationSource
        visible: screenBezel.visible
        z: webviewFlash.z + 1
    }

    // Bezel
    Image {
        id: screenBezel
        width: 0; height: window.height
        anchors.centerIn: parent
        antialiasing: true
        smooth: true
        mipmap: true
        fillMode: Image.Stretch
        source: "qrc:/img/bezel.png"
        visible: bezelActif
        z: webviewFlash.z + 2
    }

    // Fond d'écran par défaut (PacMan)
    Image {
        anchors.fill: parent
        antialiasing: true
        smooth: true
        fillMode: Image.PreserveAspectCrop
        source: "qrc:/img/background.jpg"
        z: webviewFlash.z
    }



    ///////////////////////////////////////////////////////////////////////////
    // Pour cadrer une capture d'écran
    ///////////////////////////////////////////////////////////////////////////
    ShaderEffectSource {
        id: cadrageCapture
        visible: false
        width: widthJeu; height: heightJeu
        sourceItem: webviewFlash
        //sourceRect: Qt.rect(shot_area.x, shot_area.y, shot_area.width, shot_area.height)
    }

    function calculerLaPositionJeu()
    {
        var xJeu;
        var yJeu;

        xJeu = (webviewFlash.width / 2) - (widthJeu / 2);
        yJeu = (webviewFlash.height / 2) - (heightJeu / 2);

        cadrageCapture.sourceRect = Qt.rect(xJeu, yJeu, widthJeu, heightJeu);

        //testRec.x = xJeu;
        //testRec.y = yJeu;
        //testRec.width = widthJeu;
        //testRec.height = heightJeu;
    }

    /*Rectangle {
        id: testRec
        color: "red"
        opacity: 0.4
        z: webviewFlash.z + 50
    }*/



    ///////////////////////////////////////////////////////////////////////////
    // Navigateur internet
    ///////////////////////////////////////////////////////////////////////////
    WebEngineView {
        id: webviewFlash
        anchors.fill: parent
        focus: true
        onUrlChanged: {
            adresseEnCoursUrl = url;

            if (adresseEnCoursUrl.length > 0 && adresseEnCoursUrl.search("http") === -1) {
                if (bezelActifOrigine) {
                    bezelActif = true;
                }
                isSWF = true;
            } else {
                bezelActif = false;
                isSWF = false;
            }
        }
        onContextMenuRequested: function(request) { request.accepted = true }
        onNewViewRequested: function(request) {
            if (!isSWF) {
                webviewFlash.url = request.requestedUrl;
            }
        }
        onJavaScriptConsoleMessage: {
            runJavaScript("widthPlay", function(result) { widthJeu = result });
            runJavaScript("heightPlay", function(result) { heightJeu = result; receptionDonnees() });

            function receptionDonnees() {
                screenBezel.width = widthJeu + 85;
                screenBezel.height = heightJeu + 90;
                //console.log(widthJeu + " | " + heightJeu);
            }
        }
        Component.onCompleted: {
            WebEngine.settings.autoLoadImages = true;
            WebEngine.settings.pluginsEnabled = true;
            WebEngine.settings.localStorageEnabled = true;
            createWindowGames(webviewFlash.profile);
        }
    }

    // Initialisation du profil du navigateur internet
    function createWindowGames(profile) {
        profile.httpAcceptLanguage = "fr-FR";
        profile.offTheRecord = false;
        profile.httpCacheType = WebEngineProfile.DiskHttpCache;
        profile.persistentCookiesPolicy = WebEngineProfile.AllowPersistentCookies;

        // Vérifier la présence d'argument pour le répertoire de sauvegarde des données Flash
        if (savedataflash.length > 0) {
            profile.cachePath = savedataflash + "/cache";
            profile.persistentStoragePath = savedataflash + "/QtWebEngine";
        }
    }



    ///////////////////////////////////////////////////////////////////////////
    // Boîtes de dialogue
    ///////////////////////////////////////////////////////////////////////////
    // Dialogue - Indiquer une adresse internet
    Dialog {
        id: internetAdresseDialog
        modal: true
        focus: true
        title: qsTr("<font color='white'>Ouvrir une adresse internet<br>Open an internet address</font>")
        x: (window.width - width) / 2
        y: (window.height - height) / 2
        width: Math.min(window.width, window.height) * 0.75
        standardButtons: Dialog.Open | Dialog.Cancel
        Component.onCompleted: internetAdresseDialog.standardButton(Dialog.Open).enabled = false
        Column {
            spacing: 5
            TextField {
                id: adresseWebText
                width: internetAdresseDialog.availableWidth
                Layout.margins: 5
                Layout.fillWidth: true
                selectByMouse: true
                placeholderText: qsTr("Adresse internet/internet address (https://....)")
                validator: RegExpValidator { regExp: /^(?:(?:(?:https?|ftp):)?\/\/)(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z0-9\u00a1-\uffff][a-z0-9\u00a1-\uffff_-]{0,62})?[a-z0-9\u00a1-\uffff]\.)+(?:[a-z\u00a1-\uffff]{2,}\.?))(?::\d{2,5})?(?:[/?#]\S*)?$/ }

                onTextEdited: internetAdresseDialog.standardButton(Dialog.Open).enabled = acceptableInput
                onTextChanged: internetAdresseDialog.standardButton(Dialog.Open).enabled = acceptableInput
            }
        }
        onAccepted: {
            webviewFlash.url = adresseWebText.text;
            adresseWebText.text = "";
            isSWF = false;
        }
    }


    // Dialogue - À propos
    Dialog {
        id: aProposDialog
        modal: true
        focus: true
        title: qsTr("<font color='white'>À propos/About</font>")
        x: (window.width - width) / 2
        y: (window.height - height) / 2
        width: Math.min(window.width, window.height) * 0.75
        standardButtons: Dialog.Close
        Column {
            id: aProposColumn
            anchors.fill: parent
            spacing: 5

            Image {
                width: 180
                fillMode: Image.PreserveAspectFit
                mipmap: true
                antialiasing: true
                smooth: true
                source: "qrc:/img/icon.png"
            }
            Label {
                width: aProposDialog.availableWidth
                font.pixelSize: 14
                wrapMode: Label.Wrap
                text: qsTr("<b>ArcadeFlashWeb</b> est un logiciel très simple qui vous permet de lire vos fichiers Flash (SWF) en local ou depuis une adresse internet. Il fut initialement développé pour les Bornes d'Arcade.<br><br>
                       <b>ArcadeFlashWeb</b> is a very simple software which allows you to play your Flash files (SWF) locally or from an internet address. It was originally developed for Arcade Cabinet.<br>")
            }

            Label {
                width: aProposDialog.availableWidth
                font.pixelSize: 14
                wrapMode: Label.Wrap
                text: qsTr("Logo created by <b>Hel Mic</b>.<br>")
            }
            Label {
                width: aProposDialog.availableWidth
                wrapMode: Label.Wrap
                font.pixelSize: 14
                text: qsTr("<i>Copyright © 2021, <b>Yohan DAUPHIN</b> (AureyoBoss). All rights reserved.</i><br>")
            }
            Label {
                width: aProposDialog.availableWidth
                wrapMode: Label.Wrap
                font.pixelSize: 14
                text: qsTr("Version " + version + " (" + build + ").")
            }
        }
    }

    // Dialogue - Aide
    Dialog {
        id: aideDialog
        modal: true
        focus: true
        title: qsTr("<font color='white'>Aide/Help</font>")
        x: (window.width - width) / 2
        y: (window.height - height) / 2
        width: Math.min(window.width, window.height) * 0.75
        standardButtons: Dialog.Close
        Column {
            id: aideColumn
            spacing: 5
            Label {
                width: aideDialog.availableWidth
                font.pixelSize: 12
                wrapMode: Label.Wrap
                text: qsTr('<u>Lignes de commandes disponibles</u> :<br><br>
                        > <b>-source:</b> - Spécifiez le chemin du fichier SWF (<i>exemple : -source:"C:/Users/AureyoBoss/Downloads/phoenotopia.swf"</i>).<br>
                        > <b>-swfwidth:</b> - Spécifiez la largeur naturelle du fichier SWF (<i>exemple : -swfwidth:900</i>).<br>
                        > <b>-swfheight:</b> - Spécifiez la hauteur naturelle du fichier SWF (<i>exemple : -swfheight:600</i>).<br>
                        > <b>-savedataflash:</b> - Spécifiez le chemin pour enregistrer les données du jeu Flash (<i>exemple : -savedataflash:"D:/RetroBat/Flash"</i>).<br>
                        > <b>-profilantimicro:</b> - Spécifiez le profil que vous souhaitez utiliser dans AntiMicro. Le profil doit être présent dans <b>/ArcadeFlashWeb/antimicro/profiles</b> (<i>exemple : -profilantimicro:arcadeflashweb.gamecontroller.amgp</i>).<br>
                        > <b>-controleurantimicro:</b> - Appliquez le fichier de configuration AntiMicro à un contrôleur spécifique, indiquez le GUID de votre contrôleur.<br>
                        > <b>-screentype:</b> - Pour simuler un écran CRT, spécifiez <b>crt</b> (<i>exemple : -screentype:crt</i>). Pour simuler le mode Scanlines, spécifiez <b>scanlines</b> (<i>exemple : -screentype:scanlines</i>).<br>
                        > <b>-fullscreen</b> - Pour lancer le jeu Flash en plein écran.<br>
                        > <b>-nodatetime</b> - Supprimer la date et heure.<br>
                        > <b>-picturesfolder:</b> - Spécifiez le chemin pour enregistrer les <b>captures</b>, par défaut, répertoire « <i>Images</i> » (exemple : <i>-picturesfolder:"D:/RetroBat/Screenshots"</i>).
                    <br>')
            }
            Label {
                width: aideDialog.availableWidth
                font.pixelSize: 12
                wrapMode: Label.Wrap
                text: qsTr('<u>Command line options available</u> :<br><br>
                        > <b>-source:</b> - Specify the path of the SWF file (<i>example : -source:"C:/Users/AureyoBoss/Downloads/phoenotopia.swf"</i>).<br>
                        > <b>-swfwidth:</b> - Specify the natural width of the SWF file (<i>example : -swfwidth:900</i>).<br>
                        > <b>-swfheight:</b> - Specify the natural height of the SWF file (<i>example : -swfheight:600</i>).<br>
                        > <b>-savedataflash:</b> - Specify the path to save game data of the Flash file (<i>example : -savedataflash:"D:/RetroBat/Flash"</i>).<br>
                        > <b>-profilantimicro:</b> - Specify the profile you want to use in AntiMicro. The profile must be present in <b>/ArcadeFlashWeb/antimicro/profiles</b> (<i>example : -profilantimicro:arcadeflashweb.gamecontroller.amgp</i>).<br>
                        > <b>-controleurantimicro:</b> - Apply configuration file AntiMicro to a specific controller, indicate GUID of your controller.<br>
                        > <b>-screentype:</b> - To simulate a CRT screen, specify <b>crt</b> (<i>example : -screentype:crt</i>). To simulate Scanlines, specify <b>scanlines</b> (<i>example : -screentype:scanlines</i>).<br>
                        > <b>-fullscreen</b> - To lauch Flash game in fullscreen.<br>
                        > <b>-nodatetime</b> - Remove date and time.<br>
                        > <b>-picturesfolder:</b> - Specify the path to save <b>screenshots</b>, by default is « <i>Pictures</i> » folder (example : <i>-picturesfolder:"D:/RetroBat/Screenshots"</i>).
                    <br>')
            }
        }
    }


    // Dialogue - Pas de SWF trouvé
    Dialog {
        id: pasSWFDialog
        modal: true
        focus: true
        title: qsTr("<font color='white'>ArcadeFlashWeb</font>")
        x: (window.width - width) / 2
        y: (window.height - height) / 2
        width: Math.min(window.width, window.height) * 0.75
        standardButtons: Dialog.Close
        Column {
            spacing: 20
            Label {
                width: pasSWFDialog.availableWidth
                font.pixelSize: 14
                wrapMode: Label.Wrap
                text: qsTr("Fichier non trouvé...<br><br>File not found...")
            }
        }
        onClosed: Qt.quit()
    }


    // Dialogue - Quitter
    Dialog {
        id: quitterAFWDialog
        modal: true
        focus: true
        title: qsTr("<font color='white'>Quitter/Quit</font>")
        x: (window.width - width) / 2
        y: (window.height - height) / 2
        width: Math.min(window.width, window.height) * 0.75
        standardButtons: Dialog.Yes | Dialog.No
        Column {
            spacing: 20
            Label {
                width: quitterAFWDialog.availableWidth
                font.pixelSize: 14
                wrapMode: Label.Wrap
                text: qsTr("Voulez-vous quitter <b>ArcadeFlashWeb</b> ?<br><br>Do you want to quit <b>ArcadeFlashWeb</b> ?")
            }
        }
        onAccepted: window.close()
    }


}
