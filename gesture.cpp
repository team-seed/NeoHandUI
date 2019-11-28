#include "gesture.h"
Gesture::Gesture(){
    tracking_timer.setTimerType(Qt::PreciseTimer);
    tracking_timer.setInterval(8);
    QObject::connect(&tracking_timer ,SIGNAL(timeout()) ,this ,SLOT(Get()) );

    swipe = 0.05;
    ges_cur = gesture_t(0.f, 0.f, -1);
#ifdef SECOND_HAND
    ges_cur_second = gesture_t(0.f, 0.f, -1);
#endif
}

float Gesture::Readx(){
    return ges_cur.x;
}

float Gesture::Ready(){
    return ges_cur.y;
}

void Gesture::Get(){
    //更新
    ges_last = ges_cur;

    //# Gesture Library
    //* Discription:
    //  * screen as 256*256, u-v coordinate system
    //  * x= bounding box central u, y= bounding box central v, z= gestureID
    //* Create gesture a object:
    landmarks_to_shm::gesture gesObj(
        landmarks_datatype::norm_landmark_name,
        landmarks_datatype::bbCentral_name,
        landmarks_datatype::shm_name);

    //* Get share memory array rom shared library
    //  * open the managed segment
    boost::interprocess::managed_shared_memory segment(
        boost::interprocess::open_or_create, gesObj.shm_name_,
        landmarks_datatype::shm_size);

    //  * find the share memory array
    landmarks_datatype::coordinate3d_t *bbCentral =
        segment.find<landmarks_datatype::coordinate3d_t>(
        gesObj.bbCentral_shm_name_).first;

    //* get bounding box central u
    //* get bounding box central v
    //* Get gestureID
    //  * if id=-1 not a predefined gesture
    //  * else id=0~31 is a predefined gesture
    ges_cur = {bbCentral[0].x, bbCentral[0].y, (int)bbCentral[0].z};

#ifdef SECOND_HAND
    //更新
    ges_last_second = ges_cur_second;

    //# Gesture Library
    //* Discription:
    //  * screen as 256*256, u-v coordinate system
    //  * x= bounding box central u, y= bounding box central v, z= gestureID
    //* Create gesture a object:
    landmarks_to_shm::gesture gesObj_second(
        landmarks_datatype::norm_landmark_name_second,
        landmarks_datatype::bbCentral_name_second,
        landmarks_datatype::shm_name_second);

    //* Get share memory array rom shared library
    //  * open the managed segment
    boost::interprocess::managed_shared_memory segment_second(
        boost::interprocess::open_or_create, gesObj_second.shm_name_,
        landmarks_datatype::shm_size);

    //  * find the share memory array
    landmarks_datatype::coordinate3d_t *bbCentral_second =
        segment_second.find<landmarks_datatype::coordinate3d_t>(
        gesObj_second.bbCentral_shm_name_).first;

    //* get bounding box central u
    //* get bounding box central v
    //* Get gestureID
    //  * if id=-1 not a predefined gesture
    //  * else id=0~31 is a predefined gesture
    ges_cur_second = {bbCentral_second[0].x, bbCentral_second[0].y, (int)bbCentral_second[0].z};
    std::cout << ges_cur_second;
#endif
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
    if (ges_cur.id != ges_last.id) {

        if (ges_cur.id == -1) {
            cur_gest = -1;
            emit untrigger();
        }
        //ges1 介於0~10
        else if (0 <= ges_cur.id && ges_cur.id < 10 && cur_gest != 0) {
            cur_gest = 0;
            emit trigger();
        }

//        if( (cur_x-last_x) > x_shift )
//            emit Xchanged();
    }

    //手勢不變 x變 ****新增手勢要加****
//    else if ( 0 <= ges_cur.id && ges_cur.id < 10)
//        if( qAbs(cur_x-last_x) > x_shift )
//            emit Xchanged();
}


void Gesture::check_movement(){
    gesture_t tmp = ges_cur - ges_last;

    //算角度 (0~pi/2)第一 (pi/2 ~ pi)第二 (－pi～－pi/2)第三 ( -pi/2～0)第四
    if( qSqrt(qPow(tmp.x,2) + qPow(tmp.y,2)) >= swipe ){

        //水平或垂直
        if( tmp.x == 0.f ){
            //垂直位移達標
            if( tmp.y > 0.f ) emit down_swipe();
            else emit up_swipe();
            return;
        }
        else if ( tmp.y == 0.f ) {
            //水平位移達標
            if( tmp.x > 0.f ) emit right_swipe();
            else emit left_swipe();
            return;
        }

        double angle = qRadiansToDegrees(qAtan2(qAbs(tmp.y), qAbs(tmp.x)));

        if (angle < 50) {
            if (tmp.x > 0) emit right_swipe();
            else emit left_swipe();
        }

        if (angle > 40) {
            if (tmp.y > 0) emit down_swipe();
            else emit up_swipe();
        }
    }
}

std::ostream& operator <<(std::ostream& os, const gesture_t &ges)
{
    os << "gesture: " << ges.x << " " << ges.y << " " << ges.id << "\n";
    return os;
}

