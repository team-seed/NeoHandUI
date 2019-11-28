#ifndef GESTURE_H
#define GESTURE_H

#include "../mediapipe/mediapipe/landmarks_to_shm/landmarks_to_shm.h"
#include <QObject>
#include <QTimer>
#include <QtMath>
#include <QtDebug>

#include <iostream>

struct gesture_t{
    float x, y;
    int id;

    gesture_t(float _x = 0.f, float _y = 0.f, int _id = -1)
        :x(_x), y(_y), id(_id){}

    gesture_t& operator =(const gesture_t &ges)
    {
        x = ges.x; y = ges.y; id = ges.id;
        return *this;
    }

    gesture_t operator -(const gesture_t &ges) const
    {
        return gesture_t(x-ges.x, y-ges.y, id);
    }
};

std::ostream& operator <<(std::ostream& os, const gesture_t &ges);

class Gesture : public QObject
{
    Q_OBJECT
    Q_PROPERTY(float hand_x READ Readx NOTIFY Xchanged )
    Q_PROPERTY(float hand_y READ Ready NOTIFY Ychanged )

public slots:
    //get x,y,id
    void Get();

    void start() {
        tracking_timer.start();
    }

signals:
    void up_swipe();
    void down_swipe();
    void left_swipe();
    void right_swipe();
    void trigger();
    void untrigger();

    void Xchanged();
    void Ychanged();

public:
    Gesture();

    //click or hold
    void check_type();
    //swipe
    void check_movement();

    float Readx();
    float Ready();

    //數值更新寫在 GET() 開頭
    gesture_t ges_last;
    gesture_t ges_cur;
    int cur_gest;
    float swipe;  //定義移動多少觸發swipe

#ifdef SECOND_HAND
    gesture_t ges_last_second;
    gesture_t ges_cur_second;
#endif

    QTimer tracking_timer;
};

#endif // GESTURE_H
