//
//  AssignmentDetailModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 02/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AssignmentDetailModel: NSObject {
    var assignment_id = ""
    var assignment_image = ""
    var chapter_name = ""
    var created_at = ""
    var note = ""
    var subject_name = ""
    var teacher_name = ""
    var assignment_type = ""
    var school_class_id = ""
    var school_class_list = [AssignmentDetailSchoolClassModel]()
    
    func objectMapping(json: JSON) {
        assignment_id = json["data"]["assignment_detail"]["assignment_id"].stringValue
        assignment_image = json["data"]["assignment_detail"]["assignment_image"].stringValue
        chapter_name = json["data"]["assignment_detail"]["chapter_name"].stringValue
        created_at = json["data"]["assignment_detail"]["created_at"].stringValue
        assignment_type = json["data"]["assignment_detail"]["assignment_type"].stringValue
        note = json["data"]["assignment_detail"]["note"].stringValue
        school_class_id = json["data"]["assignment_detail"]["school_class_id"].stringValue
        subject_name = json["data"]["assignment_detail"]["subject_name"].stringValue
        teacher_name = json["data"]["assignment_detail"]["teacher_name"].stringValue
        for data in json["data"]["assignment_detail"]["school_class_list"].arrayValue {
            let d = AssignmentDetailSchoolClassModel()
            d.objectMapping(json: data)
            school_class_list.append(d)
        }
    }
}

class AssignmentDetailSchoolClassModel: NSObject {
    var due_date = ""
    var assignment_id = ""
    var school_class = ""
    var status = 0
    
    func objectMapping(json: JSON) {
        due_date = json["due_date"].stringValue
        assignment_id = json["assignment_id"].stringValue
        school_class = json["school_class"].stringValue
        status = json["status"].intValue
    }
}
