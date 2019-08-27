//
//  TeacherOnDutyChildListModel.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 16/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class TeacherOnDutyChildListModel: NSObject {
    
    var class_info = [TeacherOnDutyClassInfoModel]()
    var school_class = ""
    var teacher_name = ""
    
    func objectMapping(json: JSON) {
        school_class = json["data"]["get_child"]["class_info"]["school_class"].stringValue
        teacher_name = json["data"]["get_child"]["class_info"]["teacher_name"].stringValue
        for data in json["data"]["get_child"]["student"].arrayValue {
            let d = TeacherOnDutyClassInfoModel()
            d.objectMapping(json: data)
            class_info.append(d)
        }
    }
}
class TeacherOnDutyClassInfoModel: NSObject {
    var child_id = ""
    var child_name = ""
    var child_image = ""
    var child_nis = ""
    var status = 0
    var early_leave = 0
    var late_info = 0
    
    func objectMapping(json: JSON) {
        child_id = json["child_id"].stringValue
        child_name = json["child_name"].stringValue
        child_image = json["child_image"].stringValue
        child_nis = json["child_nis"].stringValue
        status = json["status"].intValue
        early_leave = json["early_leave"].intValue
        late_info = json["late_info"].intValue
    }
}


