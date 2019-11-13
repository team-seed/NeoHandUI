#ifndef Effect_play_H
#define Effect_play_H
#include <QtConcurrent>
#include <QThreadPool>
#include <QSoundEffect>
#include "Object_pool.h"
#define EFFECT_POOL_COUNT 5

class Effect_play : public QObject,public QRunnable{
    Q_OBJECT
public:
    Effect_play(){
        QRunnable::setAutoDelete(false);
        Q.setMaxThreadCount(EFFECT_POOL_COUNT);
    }

    void init(int object_pool_size=10,QUrl url=QUrl("")){
        pool.init(object_pool_size,url);
    }

    static void fun1(QSoundEffect *s,Object_pool *p){
        s->play();
        p->ret_elem(s);
    }

    void play(){
        QtConcurrent::run(&Q, fun1,pool.get_elem(), &pool);
    }

    void run(){}

private:
    Object_pool pool;
    QSoundEffect *sound[EFFECT_POOL_COUNT];
    QThreadPool Q;
};
#endif // Effect_play_H

//QUrl::fromLocalFile(":/rythm.wav")
