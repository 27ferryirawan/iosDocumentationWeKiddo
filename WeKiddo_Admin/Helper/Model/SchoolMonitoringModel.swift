//
//  SchoolMonitoringModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 31/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class SchoolMonitoringModel: NSObject {
    var parent_total_user = 0
    var parent_total_download = 0
    var student_total_user = 0
    var student_total_download = 0
    var school_total_user = 0
    var school_total_download = 0
    var attendance_clock_in = 0
    var attendance_clock_out = 0
    var total_assignment = 0
    var pending_assignment = 0
    var total_announcement = 0
    var pending_announcement = 0
    var total_exam = 0
    var pending_exam = 0
    var school_grade = ""
    var school_id = ""
    var school_name = ""
    var school_logo = ""
    
    func objectMapping(json: JSON) {
        parent_total_user = json["data"]["information"]["parent_info"]["total_user"].intValue
        parent_total_download = json["data"]["information"]["parent_info"]["total_download"].intValue
        student_total_user = json["data"]["information"]["student_info"]["total_user"].intValue
        student_total_download = json["data"]["information"]["student_info"]["total_download"].intValue
        school_total_user = json["data"]["information"]["school_download"]["total_user"].intValue
        school_total_download = json["data"]["information"]["school_download"]["total_download"].intValue
        attendance_clock_in = json["data"]["information"]["attendance"]["clock_in"].intValue
        attendance_clock_out = json["data"]["information"]["attendance"]["clock_out"].intValue
        total_assignment = json["data"]["information"]["assignment"]["total"].intValue
        pending_assignment = json["data"]["information"]["assignment"]["pending"].intValue
        total_announcement = json["data"]["information"]["announcement"]["total"].intValue
        pending_announcement = json["data"]["information"]["announcement"]["pending"].intValue
        total_exam = json["data"]["information"]["exam"]["total"].intValue
        pending_exam = json["data"]["information"]["exam"]["pending"].intValue
        school_grade = json["data"]["information"]["school_info"]["school_grade"].stringValue
        school_id = json["data"]["information"]["school_info"]["school_id"].stringValue
        school_name = json["data"]["information"]["school_info"]["school_name"].stringValue
        school_logo = json["data"]["information"]["school_info"]["school_logo"].stringValue
    }
}
