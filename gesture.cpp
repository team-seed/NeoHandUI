#include "gesture.h"
Gesture::Gesture(){
    tracking_timer.setTimerType(Qt::PreciseTimer);
    tracking_timer.setInterval(4);
    QObject::connect(&tracking_timer, SIGNAL(timeout()), this, SLOT(Get()));

    ges_cur = gesture_t(0, 0, -1);
    ges_last = gesture_t(0, 0, -1);
}

int Gesture::pos() {
    return position;
}

void Gesture::normalize(){
    if ((ges_cur.x > upperbound) || (ges_cur.x < lowerbound))
        position = -1;
    else
        position = qMin(15, qFloor((ges_cur.x - lowerbound) * 16 / (upperbound - lowerbound)));

    if ((ges_cur.y > floor) || (ges_cur.y < ceiling))
        height = -1;
    else
        height = qMin(15, qFloor((ges_cur.y - ceiling) * 16 / (floor - ceiling)));
}

void Gesture::Get(){
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

    last_position = position;
    last_height = height;

    normalize();
    emit posChanged();

    check_type();
    check_movement();
}


void Gesture::check_type(){
    //手勢改變
    if (ges_cur.id != ges_last.id) {
        if (ges_cur.id == -1 && cur_gest != -1) {
            cur_gest = -1;
            emit untrigger();
        }
        //ges1 介於0~10
        else if (0 <= ges_cur.id && ges_cur.id < 10 && cur_gest != 0) {
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

std::ostream& operator <<(std::ostream& os, const gesture_t &ges)
{
    os << "gesture: " << ges.x << " " << ges.y << " " << ges.id << "\n";
    return os;
}

