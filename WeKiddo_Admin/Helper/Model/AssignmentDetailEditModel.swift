//
//  AssignmentDetailEditModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 08/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AssignmentDetailEditModel: NSObject {
    var assignment_id = ""
    var teacher_id = ""
    var year_id = ""
    var score_type_id = ""
    var subject_id = ""
    var school_level_id = ""
    var school_grade_id = ""
    var chapter_id = ""
    var school_major_id = ""
    var school_id = ""
    var assignment_image = ""
    var chapter_name = ""
    var created_at = ""
    var note = ""
    var subject_name = ""
    var teacher_name = ""
    var assignment_type = ""
    var school_class_id = ""
    var school_class_list = [AssignmentDetailEditSchoolClassModel]()
    var subject = [AssignmentDetailSubjectModel]()
    var schoolClass = [AssignmentDetailEditClassModel]()
    var schoolChapter = [AssignmentDetailEditChapterModel]()
    
    func objectMapping(json: JSON) {
        assignment_id = json["data"]["assignment_edit"]["assignment_edit"]["assignment_id"].stringValue
        teacher_id = json["data"]["assignment_edit"]["assignment_edit"]["teacher_id"].stringValue
        year_id = json["data"]["assignment_edit"]["assignment_edit"]["year_id"].stringValue
        score_type_id = json["data"]["assignment_edit"]["assignment_edit"]["score_type_id"].stringValue
        subject_id = json["data"]["assignment_edit"]["assignment_edit"]["subject_id"].stringValue
        school_level_id = json["data"]["assignment_edit"]["assignment_edit"]["school_level_id"].stringValue
        school_grade_id = json["data"]["assignment_edit"]["assignment_edit"]["school_grade_id"].stringValue
        chapter_id = json["data"]["assignment_edit"]["assignment_edit"]["chapter_id"].stringValue
        school_major_id = json["data"]["assignment_edit"]["assignment_edit"]["school_major_id"].stringValue
        school_id = json["data"]["assignment_edit"]["assignment_edit"]["school_id"].stringValue
        assignment_image = json["data"]["assignment_edit"]["assignment_edit"]["assignment_image"].stringValue
        chapter_name = json["data"]["assignment_edit"]["assignment_edit"]["chapter_name"].stringValue
        created_at = json["data"]["assignment_edit"]["assignment_edit"]["created_at"].stringValue
        assignment_type = json["data"]["assignment_edit"]["assignment_edit"]["assignment_type"].stringValue
        note = json["data"]["assignment_edit"]["assignment_edit"]["note"].stringValue
        school_class_id = json["data"]["assignment_edit"]["assignment_edit"]["school_class_id"].stringValue
        subject_name = json["data"]["assignment_edit"]["assignment_edit"]["subject_name"].stringValue
        teacher_name = json["data"]["assignment_edit"]["assignment_edit"]["teacher_name"].stringValue
        for data in json["data"]["assignment_edit"]["assignment_edit"]["school_class_list"].arrayValue {
            let d = AssignmentDetailEditSchoolClassModel()
            d.objectMapping(json: data)
            school_class_list.append(d)
        }
        for data in json["data"]["assignment_edit"]["subject"].arrayValue {
            let d = AssignmentDetailSubjectModel()
            d.objectMapping(json: data)
            subject.append(d)
        }
        for data in json["data"]["assignment_edit"]["class"].arrayValue {
            let d = AssignmentDetailEditClassModel()
            d.objectMapping(json: data)
            schoolClass.append(d)
        }
        for data in json["data"]["assignment_edit"]["chapter"].arrayValue {
            let d = AssignmentDetailEditChapterModel()
            d.objectMapping(json: data)
            schoolChapter.append(d)
        }
    }
}

class AssignmentDetailEditChapterModel: NSObject {
    var chapter_id = ""
    var chapter_name = ""
    
    func objectMapping(json: JSON) {
        chapter_id = json["chapter_id"].stringValue
        chapter_name = json["chapter_name"].stringValue
    }
}

class AssignmentDetailEditClassModel: NSObject {
    var school_class_id = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        school_class_id = json["school_class_id"].stringValue
        school_class = json["school_class"].stringValue
    }
}

class AssignmentDetailSubjectModel: NSObject {
    var subject_name = ""
    var subject_id = ""
    
    func objectMapping(json: JSON) {
        subject_name = json["subject_name"].stringValue
        subject_id = json["subject_id"].stringValue
    }
}

class AssignmentDetailEditSchoolClassModel: NSObject {
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
