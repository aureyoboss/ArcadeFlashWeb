#ifndef DRIVESCLASS
#define DRIVESCLASS

#include <QObject>

class DrivesClass : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList drives READ drivesList NOTIFY drivesChanged)

public:
    explicit DrivesClass(QObject *parent = nullptr);
    QStringList const& drivesList();

signals:
    void drivesChanged();

public slots:

private:
    QStringList m_drives;
};


#endif // DRIVESCLASS
