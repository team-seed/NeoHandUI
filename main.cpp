#include <QQmlApplicationEngine>
#include <QApplication>
#include <QQuickWidget>

#include "Game.h"
#include "Game_process.h"
#include "Game_timer.h"
#include "Songselect.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    qmlRegisterType<Songselect>("custom.songselect", 1, 0, "CustomSongselect");
    qmlRegisterType<Game_process>("custom.game.process", 1, 0, "CustomGameProcess");
    qmlRegisterType<Game_timer>("custom.game.timer", 1, 0, "CustomGameTimer");

    QApplication app(argc, argv);
    Game *widget=new Game();
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    widget->setSource(url);
    widget->init();
    widget->showFullScreen();

    return app.exec();
}
