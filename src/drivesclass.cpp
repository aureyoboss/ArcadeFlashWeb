#include "drivesclass.h"
#include <QStorageInfo>

DrivesClass::DrivesClass(QObject *parent) : QObject(parent)
{
}

QStringList const& DrivesClass::drivesList()
{
    m_drives.clear();

    foreach (const QStorageInfo &storage, QStorageInfo::mountedVolumes()) {
        if (storage.isValid() && storage.isReady()) {
            m_drives.append(storage.rootPath());
        }
    }

    return m_drives;
}
