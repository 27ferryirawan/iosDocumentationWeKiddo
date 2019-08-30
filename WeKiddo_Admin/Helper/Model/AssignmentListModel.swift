//
//  AssignmentModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 19/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SwiftyJSON

class AssignmentListModel {
    var assignmentList = [AssignmentListTeacherModel]()
    
    func objectMapping(json: JSON) {
        for data in json["data"]["assignments"].arrayValue {
            let d = AssignmentListTeacherModel()
            d.objectMapping(json: data)
            assignmentList.append(d)
        }
    }
}

class AssignmentListContentModel: NSObject {
    var assignment_id = ""
    var school_class = ""
    var school_class_id = ""
    var subject_name = ""
    var subject_color = ""
    var chapter_name = ""
    var class_assign_date = ""
    var due_date = ""
    var teacher_id = ""
    
    func objectMapping(json: JSON) {
        assignment_id = json["assignment_id"].stringValue
        school_class = json["school_class"].stringValue
        subject_name = json["subject_name"].stringValue
        subject_color = json["subject_color"].stringValue
        chapter_name = json["chapter_name"].stringValue
        class_assign_date = json["class_assign_date"].stringValue
        due_date = json["due_date"].stringValue
        teacher_id = json["teacher_id"].stringValue
        school_class_id = json["school_class_id"].stringValue
    }
}

class AssignmentListTeacherModel: NSObject {
    var teacher_id = ""
    var teacher_name = ""
    var assignment = [AssignmentListContentModel]()
    
    func objectMapping(json: JSON) {
        teacher_id = json["teacher_id"].stringValue
        teacher_name = json["teacher_name"].stringValue
        for data in json["assignment"].arrayValue {
            let d = AssignmentListContentModel()
            d.objectMapping(json: data)
            assignment.append(d)
        }
    }
}
