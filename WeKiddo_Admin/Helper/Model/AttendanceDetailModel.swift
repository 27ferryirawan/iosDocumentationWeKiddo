//
//  AttendanceDetailModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 27/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AttendanceDetailModel: NSObject {
    var chapter_name = ""
    var session_date = ""
    var start_time = ""
    var end_time = ""
    var subject_id = ""
    var school_session_id = ""
    var school_class = ""
    var subject_name = ""
    var attendance_time = ""
    var chapter_desc = ""
    var teacher_name = ""
    var flag = 0
    var attendanceStudent = [AttendanceStudentModel]()

    func objectMapping(json: JSON) {
        teacher_name = json["data"]["attendance_list"]["teacher_name"].stringValue
        chapter_desc = json["data"]["attendance_list"]["chapter_desc"].stringValue
        chapter_name = json["data"]["attendance_list"]["chapter_name"].stringValue
        session_date = json["data"]["attendance_list"]["session_date"].stringValue
        start_time = json["data"]["attendance_list"]["start_time"].stringValue
        end_time = json["data"]["attendance_list"]["end_time"].stringValue
        subject_id = json["data"]["attendance_list"]["subject_id"].stringValue
        school_session_id = json["data"]["attendance_list"]["school_session_id"].stringValue
        school_class = json["data"]["attendance_list"]["school_class"].stringValue
        subject_name = json["data"]["attendance_list"]["subject_name"].stringValue
        attendance_time = json["data"]["attendance_list"]["attendance_time"].stringValue
        flag = json["data"]["attendance_list"]["flag"].intValue
        for data in json["data"]["attendance_list"]["students"].arrayValue {
            let d = AttendanceStudentModel()
            d.objectMapping(json: data)
            attendanceStudent.append(d)
        }
    }
}

class AttendanceStudentModel: NSObject {
    var childID = ""
    var childName = ""
    var childImage = ""
    var isAttend = Bool()
    
    func objectMapping(json: JSON) {
        childID = json["child_id"].stringValue
        childName = json["child_name"].stringValue
        childImage = json["child_image"].stringValue
        isAttend = json["is_attend"].boolValue
    }
}
