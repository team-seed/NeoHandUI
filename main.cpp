#include <QQmlApplicationEngine>
#include <QApplication>
#include <QQuickWidget>

#include "Game.h"

#include "Songselect.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    qmlRegisterType<Songselect>("custom.songselect", 1, 0, "CustomSongselect");

    QApplication app(argc, argv);
    Game *widget=new Game();
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    widget->setSource(url);
    widget->init();
    widget->show();

    return app.exec();
}
