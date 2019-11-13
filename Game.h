#ifndef GAME_H
#define GAME_H
#include <QKeyEvent>
#include <QQuickWidget>
#include <QDebug>
#include <QApplication>
#include <QQmlEngine>
#include "Effect_play.h"
class Game : public QQuickWidget {
    Q_OBJECT

signals:
    //press signal
    void uppress_signal();
    void downpress_signal();
    void leftpress_signal();
    void rightpress_signal();
    void enterpress_signal();
    void escpress_signal();
    void spacepress_signal();
    void bksppress_signal();

    //release signal
    void uprelease_signal();
    void downrelease_signal();
    void leftrelease_signal();
    void rightrelease_signal();
    void enterrelease_signal();
    void escrelease_signal();
    void spacerelease_signal();
    void bksprelease_signal();

public:
    Game(){
        QObject::connect(engine(), SIGNAL(quit()), QCoreApplication::instance(), SLOT(quit()));
        setWindowTitle("NeoHand 2: SEED OF LEGGENDARIA");
    }
    void init () {
        //set key sound effect (objectsize,QURL) 路徑要重設
        //arrow_key.init(20,QUrl("C:/Users/eaixr/Desktop/drum.wav"));
        //function_key.init(20,QUrl("C:/Users/eaixr/Desktop/drum.wav"));

        //press signal to pml signal
        QObject::connect(this, SIGNAL(uppress_signal()), (QObject*)rootObject(), SIGNAL(uppress_signal()));
        QObject::connect(this, SIGNAL(downpress_signal()), (QObject*)rootObject(), SIGNAL(downpress_signal()));
        QObject::connect(this, SIGNAL(leftpress_signal()), (QObject*)rootObject(), SIGNAL(leftpress_signal()));
        QObject::connect(this, SIGNAL(rightpress_signal()), (QObject*)rootObject(), SIGNAL(rightpress_signal()));
        QObject::connect(this, SIGNAL(enterpress_signal()), (QObject*)rootObject(), SIGNAL(enterpress_signal()));
        QObject::connect(this, SIGNAL(escpress_signal()), (QObject*)rootObject(), SIGNAL(escpress_signal()));
        QObject::connect(this, SIGNAL(spacepress_signal()), (QObject*)rootObject(), SIGNAL(spacepress_signal()));
        QObject::connect(this, SIGNAL(bksppress_signal()), (QObject*)rootObject(), SIGNAL(bksppress_signal()));

        //release signal to pml signal
        QObject::connect(this, SIGNAL(uprelease_signal()), (QObject*)rootObject(), SIGNAL(uprelease_signal()));
        QObject::connect(this, SIGNAL(downrelease_signal()), (QObject*)rootObject(), SIGNAL(downrelease_signal()));
        QObject::connect(this, SIGNAL(leftrelease_signal()), (QObject*)rootObject(), SIGNAL(leftrelease_signal()));
        QObject::connect(this, SIGNAL(rightrelease_signal()), (QObject*)rootObject(), SIGNAL(rightrelease_signal()));
        QObject::connect(this, SIGNAL(enterrelease_signal()), (QObject*)rootObject(), SIGNAL(enterrelease_signal()));
        QObject::connect(this, SIGNAL(escrelease_signal()), (QObject*)rootObject(), SIGNAL(escrelease_signal()));
        QObject::connect(this, SIGNAL(spacerelease_signal()), (QObject*)rootObject(), SIGNAL(spacerelease_signal()));
        QObject::connect(this, SIGNAL(bksprelease_signal()), (QObject*)rootObject(), SIGNAL(bksprelease_signal()));

    }

    void keyPressEvent(QKeyEvent *event)
    {
        if(event->isAutoRepeat())
            return;
        switch (event->key()) {
            case Qt::Key_Up:
                emit uppress_signal(); break;
            case Qt::Key_Down:
                emit downpress_signal(); break;
            case Qt::Key_Left:
                emit leftpress_signal(); break;
            case Qt::Key_Right:
                emit rightpress_signal(); break;
            case Qt::Key_Return:
                emit enterpress_signal(); break;
            case Qt::Key_Escape:
                emit escpress_signal(); break;
            case Qt::Key_Space:
                emit spacepress_signal(); break;
            case Qt::Key_Backspace:
                emit bksppress_signal(); break;
        }
    }

    void keyReleaseEvent(QKeyEvent *event)
    {
        if(event->isAutoRepeat())
            return;
        switch (event->key()) {
            case Qt::Key_Up:
                emit uprelease_signal(); break;
            case Qt::Key_Down:
                emit downrelease_signal(); break;
            case Qt::Key_Left:
                emit leftrelease_signal(); break;
            case Qt::Key_Right:
                emit rightrelease_signal(); break;
            case Qt::Key_Return:
                emit enterrelease_signal(); break;
            case Qt::Key_Escape:
                emit escrelease_signal(); break;
            case Qt::Key_Space:
                emit spacerelease_signal(); break;
            case Qt::Key_Backspace:
                emit bksprelease_signal(); break;
        }
    }

private:
    Effect_play arrow_key;
    Effect_play function_key;
    QKeyEvent *event;
};
#endif // GAME_H
