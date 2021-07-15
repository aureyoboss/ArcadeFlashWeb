QT += qml quick gui webengine multimedia quickcontrols2 network core svg widgets sql
CONFIG += c++11 qtquickcompiler
TEMPLATE += app
TARGET += ArcadeFlashWeb
VERSION += 1.0.2

QMAKE_TARGET_COMPANY = Yohan DAUPHIN
QMAKE_TARGET_PRODUCT = ArcadeFlashWeb
QMAKE_TARGET_DESCRIPTION = "ArcadeFlashWeb est un logiciel simple pour lire les fichiers Flash (SWF)."
QMAKE_TARGET_COPYRIGHT = "Copyright 2021, Yohan DAUPHIN (AureyoBoss)"

RC_ICONS = icon_ArcadeFlashWeb.ico
RC_LANG = 1036

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        drivesclass.cpp \
        main.cpp

RESOURCES += qml.qrc
OTHER_FILES += translations/*.qm

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    drivesclass.h \
    launcherapp.h \
    maintenance.h
