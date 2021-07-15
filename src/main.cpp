#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QApplication>
#include <QQmlContext>
#include <QTranslator>
#include <QtQuick>
#include <QQuickStyle>
#include <QtQuickControls2>
#include <QIcon>
#include <QtWebEngine>
#include <QtWebEngine/qtwebengineglobal.h>
#include <QStandardPaths>
#include <QStringList>
#include <QSystemSemaphore>
#include <QSharedMemory>
#include <QMessageBox>
#include <QStringList>
#include <QProcess>

#include "drivesclass.h"
#include "maintenance.h"
#include "launcherapp.h"

int main(int argc, char *argv[])
{

    // Activer l'HighDpiScaling
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    // Désactiver l'icone Help sur les fenêtres
    QCoreApplication::setAttribute(Qt::AA_DisableWindowContextHelpButton);

    // Lancer en mode Software (pour les captures par Windows)
    //QCoreApplication::setAttribute(Qt::AA_UseSoftwareOpenGL, true);

    // Supprimer la CACHE
    qputenv("QML_DISABLE_DISK_CACHE", "true");

    // Activer la prise en charge de Flash
    qputenv("QTWEBENGINE_CHROMIUM_FLAGS", "--enable-pepper-testing --ppapi-flash-path=./pepflashplayer.dll");

    // Initialiser le moteur internet
    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
    QtWebEngine::initialize();


    QGuiApplication app(argc, argv); // La récupération des paramètres de la fonction principale


    // Icone de l'application
    app.setWindowIcon(QIcon(":/icon_ArcadeFlashWeb.ico"));

    // Initialiser la détection des disques
    qmlRegisterType<DrivesClass>("DrivesClass", 1, 0, "DrivesClass");

    // Activer la maintenance du logiciel
    Maintenance maintenanceIO;



    QQmlApplicationEngine engine;


    // Accéder à la maintenance afin qu'elle soit disponible dans le projet
    engine.rootContext()->setContextProperty("maintenance", &maintenanceIO);


    // Récupération des lignes de commande
    QStringList commandLine;

    for (int i=1; i < argc; i++)
    {
        //qDebug() << "Command Lines : " << QString::fromLatin1(argv[i]).toLower();
        commandLine << QString::fromLatin1(argv[i]).toLower();
    }

    if (commandLine.size() == 0) {
        commandLine << "";
    }
    // Rend disponible la variable les lignes de commande dans QML
    engine.rootContext()->setContextProperty("commandLine", commandLine);



    // Localisation du répertoire des données du logiciel
    const QString applicationDirPath = QCoreApplication::applicationDirPath();
    engine.rootContext()->setContextProperty("applicationDirPath", applicationDirPath);

    // Localisation du répertoire des données utilisateur
    const QStringList dataPath = QStandardPaths::standardLocations(QStandardPaths::DataLocation);
    engine.rootContext()->setContextProperty("dataPath", dataPath);

    // Localisation du répertoire du bureau
    const QStringList deskPath = QStandardPaths::standardLocations(QStandardPaths::DesktopLocation);
    engine.rootContext()->setContextProperty("deskPath", deskPath);

    // Localisation du répertoire Mes documents
    const QStringList documentPath = QStandardPaths::standardLocations(QStandardPaths::DocumentsLocation);
    engine.rootContext()->setContextProperty("documentPath", documentPath);

    // Localisation du répertoire utilisateur
    const QStringList homePath = QStandardPaths::standardLocations(QStandardPaths::HomeLocation);
    engine.rootContext()->setContextProperty("homePath", homePath);

    // Localisation du répertoire des photos
    const QStringList imagePath = QStandardPaths::standardLocations(QStandardPaths::PicturesLocation);
    engine.rootContext()->setContextProperty("imagePath", imagePath);

    // Localisation du répertoire des téléchargements
    const QStringList downloadPath = QStandardPaths::standardLocations(QStandardPaths::DownloadLocation);
    engine.rootContext()->setContextProperty("downloadPath", downloadPath);


    qmlRegisterType<Process>("Process", 1, 0, "Process");


    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
