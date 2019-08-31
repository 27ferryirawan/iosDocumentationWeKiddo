//
//  TotalStudentModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 31/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class TotalStudentModel: NSObject {
    var user_id = ""
    var child_name = ""
    var child_image = ""
    var log_date = ""
    
    func objectMapping(json: JSON) {
        user_id = json["user_id"].stringValue
        child_name = json["child_name"].stringValue
        child_image = json["child_image"].stringValue
        log_date = json["log_date"].stringValue
    }
}

class TotalParentModel: NSObject {
    var user_id = ""
    var parent_name = ""
    var parent_image = ""
    var log_date = ""
    
    func objectMapping(json: JSON) {
        user_id = json["user_id"].stringValue
        parent_name = json["parent_name"].stringValue
        parent_image = json["parent_image"].stringValue
        log_date = json["log_date"].stringValue
    }
}

class TotalTeacherModel: NSObject {
    var user_id = ""
    var teacher_name = ""
    var teacher_image = ""
    var log_date = ""
    
    func objectMapping(json: JSON) {
        user_id = json["user_id"].stringValue
        teacher_name = json["teacher_name"].stringValue
        teacher_image = json["teacher_image"].stringValue
        log_date = json["log_date"].stringValue
    }
}
