#include "gesture.h"
Gesture::Gesture(){
    tracking_timer.setTimerType(Qt::PreciseTimer);
    tracking_timer.setInterval(8);
    QObject::connect(&tracking_timer ,SIGNAL(timeout()) ,this ,SLOT(Get()) );

    x_swipe = 0.05;
    y_swipe = 0.05;
    x_shift = 0.1;
    cur_id = -1;
    cur_x = 0;
    cur_y = 0;
}
int Gesture::Readx(){
    return x;
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
    check_type();
    check_movement();
}

//當 type 改變, 送 trig or untrig 的 sig 以及 xchange 的 sig
//當 type 維持(不為-1), y 改變, 送 swipe 的 sig
//當 type 維持(不為-1), x 改變, 送 xchange 的 sig

void Gesture::check_type(){
    //手勢改變
    if(cur_id!=last_id){

        if(cur_id == -1)
        {
            emit untrigger();
            qDebug()<<cur_id;
        }

        else if( 0 <= cur_id && cur_id < 10 && last_id == -1 ) //ges1 介於0~9
        {
            emit trigger();
            qDebug()<<cur_id;
        }

        if( (cur_x-last_x) > x_shift )
            emit Xchanged();
    }

    //手勢不變 x變 ****新增手勢要加****
    else if ( 0 <= cur_id && cur_id < 10)
        if( qAbs(cur_x-last_x) > x_shift )
            emit Xchanged();
}

void Gesture::check_movement(){

    //左或右
    if( qAbs(cur_x-last_x) > x_swipe )
        if( (cur_x-last_x) > 0 )
            emit right_swipe();
        else if( (cur_x-last_x) < 0 )
            emit left_swipe();

     //上或下
    if( qAbs(cur_y-last_y) > y_swipe )
        if( (cur_y-last_y) < 0 )
            emit up_swipe();
        else if( (cur_y-last_y) > 0 )
            emit down_swipe();

}