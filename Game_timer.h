#ifndef GAME_TIMER_H
#define GAME_TIMER_H

#include <QObject>
#include <QTime>
#include <QTimer>
#include <QDebug>

class Game_timer : public QObject {

    Q_OBJECT
    Q_PROPERTY(int clock READ clock NOTIFY clockChanged)

public:
    Game_timer() {
        timer.setTimerType(Qt::PreciseTimer);
        timer.setInterval(2);
        QObject::connect(&timer, SIGNAL(timeout()), this, SIGNAL(clockChanged()));
    }

    void start() {
        m_clock.start();
    }

    int restart() {
        return m_clock.restart();
    }

    int clock() {
        return m_clock.elapsed();
    }

public slots:
    void start_looping () {
        start();
        timer.start();
    }

    void stop_looping () {
        timer.stop();
    }

signals:
    void clockChanged();

private:
    QTime m_clock;
    QTimer timer;
};

#endif // GAME_TIMER_H
