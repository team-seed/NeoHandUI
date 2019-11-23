#ifndef PLAYER_H
#define PLAYER_H
#include <QMediaPlayer>
#include <QMediaPlaylist>
#include <QQmlContext>
using namespace::std;

class Player:public QObject{
    Q_OBJECT
public:
    Player(){
    }
public slots:
    void displayErrorMessage()
    {
        qDebug()<<music.errorString();
    }

    void set_song(QUrl url = QUrl(""), bool loop = false, int start = 0) {
        if(!plist.isEmpty())
            plist.clear();
        plist.addMedia(url);
        if(loop)
            plist.setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
        music.setPlaylist(&plist);
        music.setVolume(100);
        music.setPosition(start);
    }

    void play_song() {
        music.play();
        connect(&music,QOverload<QMediaPlayer::Error>::of(&QMediaPlayer::error),
                this,&Player::displayErrorMessage);
    }

    void stop_song() {
        music.stop();
    }

    void play_bgm(QUrl url = QUrl(""), bool loop = false, int start = 0){
        if(!plist.isEmpty())
            plist.clear();
        plist.addMedia(url);
        if(loop)
            plist.setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
        music.setPlaylist(&plist);
        music.setVolume(100);
        music.setPosition(start);
        music.play();
        connect(&music,QOverload<QMediaPlayer::Error>::of(&QMediaPlayer::error),
                this,&Player::displayErrorMessage);
    }

    void stop_bgm() {
        music.stop();
    }

private:
    QUrl url;
    bool loop;
    int start;
    QMediaPlaylist plist;
    QMediaPlayer music;
};
#endif // PLAYER_H
