#ifndef GESTURE_H
#define GESTURE_H

#include "../mediapipe/mediapipe/landmarks_to_shm/landmarks_to_shm.h"
#include <QObject>
#include <QTimer>
#include <QtMath>
#include <QtDebug>
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
    int last_id;
    float last_x, last_y;
    int cur_id;
    float cur_x, cur_y;

    int cur_gest;

    float swipe;  //定義移動多少觸發swipe

    QTimer tracking_timer;
};

#endif // GESTURE_H
