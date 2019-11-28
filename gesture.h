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
    Q_PROPERTY(int hand_pos READ pos NOTIFY posChanged )

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

    void posChanged();

public:
    Gesture();

    //click or hold
    void check_type();
    //swipe
    void check_movement();

    void normalize();
    int pos();

    //數值更新寫在 GET() 開頭
    int last_id;
    int cur_gest;
    float last_x, last_y;
    int cur_id;
    float cur_x, cur_y;

    float upperbound = 0.87f;
    float lowerbound = 0.13f;
    float ceiling = 0.08f;
    float floor = 0.92f;
    int position, last_position;
    int height, last_height;

    QTimer tracking_timer;
};

#endif // GESTURE_H
