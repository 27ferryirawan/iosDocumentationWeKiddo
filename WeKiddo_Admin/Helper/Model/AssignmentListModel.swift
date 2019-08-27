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
    var assignmentList = [AssignmentContentModel]()
    var assignmentPickerSubject = [AssignmentSubjectModel]()
    var assignmentPickerClass = [AssignmentClassModel]()
    
    func objectMapping(json: JSON) {
        for data in json["data"]["assignment"]["assignment_list"].arrayValue {
            let d = AssignmentContentModel()
            d.objectMapping(json: data)
            assignmentList.append(d)
        }
        for data in json["data"]["assignment"]["subject"].arrayValue {
            let d = AssignmentSubjectModel()
            d.objectMapping(json: data)
            assignmentPickerSubject.append(d)
        }
        for data in json["data"]["assignment"]["class"].arrayValue {
            let d = AssignmentClassModel()
            d.objectMapping(json: data)
            assignmentPickerClass.append(d)
        }
    }
}

class AssignmentContentModel: NSObject {
    var assignment_id = ""
    var school_class = ""
    var subject_name = ""
    var chapter_name = ""
    var class_assign_date = ""
    var due_date = ""
    var teacher_id = ""
    var school_class_id = ""
    
    func objectMapping(json: JSON) {
        assignment_id = json["assignment_id"].stringValue
        school_class = json["school_class"].stringValue
        subject_name = json["subject_name"].stringValue
        chapter_name = json["chapter_name"].stringValue
        class_assign_date = json["class_assign_date"].stringValue
        due_date = json["due_date"].stringValue
        teacher_id = json["teacher_id"].stringValue
        school_class_id = json["school_class_id"].stringValue
    }
}

class AssignmentSubjectModel: NSObject {
    var subject_id = ""
    var subject_name = ""
    
    func objectMapping(json: JSON) {
        subject_id = json["subject_id"].stringValue
        subject_name = json["subject_name"].stringValue
    }
}

class AssignmentClassModel: NSObject {
    var school_class_id = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        school_class_id = json["school_class_id"].stringValue
        school_class = json["school_class"].stringValue
    }
}
