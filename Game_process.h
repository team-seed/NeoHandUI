#ifndef GAME_PROCESS_H
#define GAME_PROCESS_H

#include <QObject>
#include <QUrl>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QFile>

#include "Player.h"

struct slide {
    int time, left, right;
};

struct note {
    int time, gesture, left, right, type;
    int direction;
    QList<slide> path;
};

struct chart_section {
    double bpm;
    int offset;
    int beats;
    QList<note> notes;
};

class Game_process : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString bpm_range READ bpm_range NOTIFY bpm_rangeChanged)
    Q_PROPERTY(QVariantList chart READ chart NOTIFY chartChanged)

public:
    Game_process() {}

    QString bpm_range () {
        return m_bpm_range;
    }

    QVariantList chart() {
        return qml_chart;
    }

    void chart_toList ();

signals:
    void bpm_rangeChanged();
    void chartChanged();

public slots:
    void set_song(QString audio_path) {
        music_player.set_song(audio_path, false, 0);
    }

    void startGame() {
        playMusic();
    }

    bool song_chart_parse (QString filepath);

private:
    void playMusic() {
        music_player.play_song();
    }

    Player music_player;
    QList<chart_section> song_chart;
    QList<QList<int>> note_list;
    QString m_bpm_range;
    QVariantList qml_chart;
};

#endif // GAME_PROCESS_H
