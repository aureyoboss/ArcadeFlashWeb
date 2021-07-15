#ifndef MAINTENANCE_H
#define MAINTENANCE_H

#include <QObject>
#include <QFile>
#include <QDir>
#include <QDebug>

class Maintenance : public QObject
{
    Q_OBJECT

public slots:
    bool verifyFolder(const QString& repertoire)
    {

        if (QDir(repertoire).exists())
        {
            return true;
        }
        else {
            return false;
        }
    }

    bool verifyFile(const QString& fichier)
    {
        if (QFile::exists(fichier))
        {
            return true;
        }
        else {
            return false;
        }
    }

public:
    Maintenance() {}
};

#endif // MAINTENANCE_H
