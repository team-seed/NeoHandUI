#include "gesture.h"
Gesture::Gesture(){
    tracking_timer.setTimerType(Qt::PreciseTimer);
    tracking_timer.setInterval(8);
    QObject::connect(&tracking_timer ,SIGNAL(timeout()) ,this ,SLOT(Get()) );

    swipe = 0.05;
    cur_id = -1;
    cur_x = 0;
    cur_y = 0;
}

float Gesture::Readx(){
    return cur_x;
}

float Gesture::Ready(){
    return cur_y;
}

void Gesture::Get(){
    //更新
    last_id = cur_id;
    last_x = cur_x;
    last_y = cur_y;

    //# Gesture Library
    //* Discription:
    //  * screen as 256*256, u-v coordinate system
    //  * x= bounding box central u, y= bounding box central v, z= gestureID

    //* Create gesture a object:
    landmarks_to_shm::gesture ges;

    //* Get share memory array rom shared library
    //  * open the managed segment

    boost::interprocess::managed_shared_memory segment(
        boost::interprocess::open_or_create,
        landmarks_datatype::shm_name,
        landmarks_datatype::shm_size);

    //  * find the share memory array
    landmarks_datatype::coordinate3d_t *_bbCentral_ptr = segment.find<landmarks_datatype::coordinate3d_t>(
        landmarks_datatype::bbCentral_name).first;

    //* get bounding box central u
    float u = _bbCentral_ptr[0].x;

    //* get bounding box central v
    float v = _bbCentral_ptr[0].y;

    //* Get gestureID
    //  * if id=-1 not a predefined gesture
    //  * else id=0~31 is a predefined gesture
    int gestureID = (int)_bbCentral_ptr[0].z;

    cur_x = u;
    cur_y = v;
    cur_id = gestureID;

    emit Xchanged();
    emit Ychanged();
    check_type();
    check_movement();
}

//當 type 改變, 送 trig or untrig 的 sig 以及 xchange 的 sig
//當 type 維持(不為-1), y 改變, 送 swipe 的 sig
//當 type 維持(不為-1), x 改變, 送 xchange 的 sig

void Gesture::check_type(){
    //手勢改變
    if (cur_id != last_id) {

        if (cur_id == -1) {
            cur_gest = -1;
            emit untrigger();
        }
        //ges1 介於0~10
        else if (0 <= cur_id && cur_id < 10 && cur_gest != 0) {
            cur_gest = 0;
            emit trigger();
        }

//        if( (cur_x-last_x) > x_shift )
//            emit Xchanged();
    }

    //手勢不變 x變 ****新增手勢要加****
//    else if ( 0 <= cur_id && cur_id < 10)
//        if( qAbs(cur_x-last_x) > x_shift )
//            emit Xchanged();
}


void Gesture::check_movement(){
    float tmp_x = cur_x - last_x;
    float tmp_y = cur_y - last_y;

    //算角度 (0~pi/2)第一 (pi/2 ~ pi)第二 (－pi～－pi/2)第三 ( -pi/2～0)第四
    if( qSqrt(qPow(tmp_x,2) + qPow(tmp_y,2)) >= swipe ){

        //水平或垂直
        if( tmp_x == 0.f ){
            //垂直位移達標
            if( tmp_y > 0.f ) emit down_swipe();
            else emit up_swipe();
            return;
        }
        else if ( tmp_y == 0.f ) {
            //水平位移達標
            if( tmp_x > 0.f ) emit right_swipe();
            else emit left_swipe();
            return;
        }

        double angle = qRadiansToDegrees(qAtan2(qAbs(tmp_y), qAbs(tmp_x)));

        if (angle < 50) {
            if (tmp_x > 0) emit right_swipe();
            else emit left_swipe();
        }

        if (angle > 40) {
            if (tmp_y > 0) emit down_swipe();
            else emit up_swipe();
        }
    }
}
