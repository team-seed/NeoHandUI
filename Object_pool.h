#ifndef OBJECT_POOL_H
#define OBJECT_POOL_H
#include <QList>
#include <QSoundEffect>
#include <QDebug>
class Object_pool {

public:
    Object_pool(){
    }
    void init(int pool_size=10,QUrl url=QUrl("")){
        for (int i = 0;i < pool_size;i++){
            QSoundEffect *temp = new QSoundEffect;
            temp->setSource(url);
            temp->setVolume(1.0);
            elem.push_back(temp);
        }
    }
    QSoundEffect* get_elem(){
        if(elem.isEmpty())
           return NULL;
        if(elem.first()->isPlaying()) {
            qDebug()<<"pop";
            elem.pop_front();
        }
        return elem.takeFirst();
    }

    void ret_elem(QSoundEffect* returned_elem){
        elem.push_back(returned_elem);
    }

private:
    QList<QSoundEffect*> elem;
};

#endif // OBJECT_POOL_H
