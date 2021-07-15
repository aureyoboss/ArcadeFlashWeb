#ifndef LAUNCHERAPP_H
#define LAUNCHERAPP_H
#include <QProcess>
#include <QVariant>
#include <QDebug>

class Process : public QProcess {
    Q_OBJECT

public:
    Process(QObject *parent = 0) : QProcess(parent) { }

    Q_INVOKABLE void start(const QString &program, const QVariantList &arguments) {
        QStringList args;

        for (int i = 0; i < arguments.length(); i++) {
            args << arguments[i].toString();
        }

        //qDebug() << args;

        QProcess::start(program, args);
    }

    Q_INVOKABLE void execute(const QString &program, const QVariantList &arguments) {
        QStringList args;

        for (int i = 0; i < arguments.length(); i++) {
            args << arguments[i].toString();
        }

        //qDebug() << args;

        QProcess::execute(program, args);
    }

    Q_INVOKABLE QByteArray readAll() {
        return QProcess::readAll();
    }
};

#endif // LAUNCHERAPP_H
