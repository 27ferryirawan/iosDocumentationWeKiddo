//
//  AttendanceModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 27/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AttendanceModel: NSObject {
    var school_session_id = ""
    var session_date = ""
    var start_time = ""
    var end_time = ""
    var subject_id = ""
    var school_class_id = ""
    var school_class = ""
    var subject_name = ""
    var attendance_time = ""
    var flag = 0
    
    func objectMapping(json: JSON) {
        school_session_id = json["school_session_id"].stringValue
        session_date = json["session_date"].stringValue
        start_time = json["start_time"].stringValue
        end_time = json["end_time"].stringValue
        subject_id = json["subject_id"].stringValue
        school_class_id = json["school_class_id"].stringValue
        school_class = json["school_class"].stringValue
        subject_name = json["subject_name"].stringValue
        attendance_time = json["attendance_time"].stringValue
        flag = json["flag"].intValue
    }
}
