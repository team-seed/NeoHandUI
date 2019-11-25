#ifndef GAME_TIMER_H
#define GAME_TIMER_H

#include <QObject>
#include <QTime>
#include <QTimer>
#include <QDebug>

#include "Player.h"

class Game_timer : public QObject {

    Q_OBJECT
    Q_PROPERTY(int clock READ clock NOTIFY clockChanged)

public:
    Game_timer() {
        timer.setTimerType(Qt::PreciseTimer);
        timer.setInterval(1);
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
    void set_song(QString audio_path) {
        music_player.set_song(audio_path, false, 0);
    }

    void startGame(int time) {
        start_looping();
        QTimer::singleShot(time, Qt::PreciseTimer, this, SLOT(playMusic()));
    }

    void start_looping () {
        timer.start();
        start();
    }

    void stop_looping () {
        timer.stop();
    }

    void playMusic() {
        music_player.play_song();
    }

signals:
    void clockChanged();

private:


    Player music_player;
    QTime m_clock;
    QTimer timer;
};

#endif // GAME_TIMER_H
