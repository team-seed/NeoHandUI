#include "gesture.h"
Gesture::Gesture(){
    tracking_timer.setTimerType(Qt::PreciseTimer);
    tracking_timer.setInterval(4);
    QObject::connect(&tracking_timer ,SIGNAL(timeout()) ,this ,SLOT(Get()) );

    cur_id = -1;
    cur_x = 0;
    cur_y = 0;
}

int Gesture::pos() {
    return position;
}

void Gesture::normalize(){
    if ((cur_x > upperbound) || (cur_x < lowerbound))
        position = -1;
    else
        position = qMin(15, qFloor((cur_x - lowerbound) * 16 / (upperbound - lowerbound)));

    if ((cur_y > floor) || (cur_y < ceiling))
        height = -1;
    else
        height = qMin(11, qFloor((cur_y - ceiling) * 12 / (floor - ceiling)));
}

void Gesture::Get(){
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

    last_position = position;
    last_height = height;

    normalize();

    emit posChanged();
    check_type();
    check_movement();
}

//當 type 改變, 送 trig or untrig 的 sig 以及 xchange 的 sig
//當 type 維持(不為-1), y 改變, 送 swipe 的 sig
//當 type 維持(不為-1), x 改變, 送 xchange 的 sig

void Gesture::check_type(){
    //手勢改變
    if (cur_id != last_id) {
        if (cur_id == -1 && cur_gest != -1) {
            cur_gest = -1;
            emit untrigger();
        }
        //ges1 介於0~10
        else if (0 <= cur_id && cur_id < 10 && cur_gest != 0) {
            cur_gest = 0;
            emit trigger();
        }
    }
}


void Gesture::check_movement(){

    if (position != -1 && last_position != -1 && position != last_position) {
        int x = position - last_position;
        if (x > 0) emit right_swipe();
        else emit left_swipe();
    }

    if (height != -1 && last_height != -1 && height != last_height) {
        int y = height - last_height;
        if (y > 0) emit down_swipe();
        else emit up_swipe();
    }
}
