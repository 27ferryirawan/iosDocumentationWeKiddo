//
//  AssignmentEditModel.swift
//  WeKiddo_Admin
//
//  Created by Yosua Hoo on 28/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AssignmentEditModel : NSObject{
    var schoolUserList = [AssignmentEditSchoolUserModel]()
    var subjectList = [AssignmentEditSubjectModel]()
    var classList = [AssignmentEditClassModel]()
    var chapterList = [AssignmentEditChapterModel]()
    var content = AssignmentEditContentModel()
    
    func objectMapping(json: JSON){
        for data in json["data"]["assignment_edit"]["school_user"].arrayValue{
            let d = AssignmentEditSchoolUserModel()
            d.objectMapping(json: data)
            schoolUserList.append(d)
        }
        for data in json["data"]["assignment_edit"]["subject"].arrayValue{
            let d = AssignmentEditSubjectModel()
            d.objectMapping(json: data)
            subjectList.append(d)
        }
        for data in json["data"]["assignment_edit"]["class"].arrayValue{
            let d = AssignmentEditClassModel()
            d.objectMapping(json: data)
            classList.append(d)
        }
        for data in json["data"]["assignment_edit"]["chapter"].arrayValue{
            let d = AssignmentEditChapterModel()
            d.objectMapping(json: data)
            chapterList.append(d)
        }
        let d = AssignmentEditContentModel()
        d.objectMapping(json: json["data"]["assignment_edit"]["assignment_edit"])
        content = d
    }
}

class AssignmentEditSchoolUserModel : NSObject {
    var teacher_id = ""
    var teacher_name = ""
    
    func objectMapping(json: JSON){
        teacher_id = json ["teacher_id"].stringValue
        teacher_name = json ["teacher_name"].stringValue
    }
}

class AssignmentEditSubjectModel : NSObject {
    var subject_id = ""
    var subject_name = ""
    
    func objectMapping(json: JSON){
        subject_id = json ["subject_id"].stringValue
        subject_name = json ["subject_name"].stringValue
    }
}

class AssignmentEditClassModel : NSObject {
    var school_class_id = ""
    var school_class = ""
    
    func objectMapping(json: JSON){
        school_class_id = json ["school_class_id"].stringValue
        school_class = json ["school_class"].stringValue
    }
}

class AssignmentEditChapterModel : NSObject {
    var chapter_id = ""
    var chapter_name = ""
    
    func objectMapping(json: JSON){
        chapter_id = json ["chapter_id"].stringValue
        chapter_name = json ["chapter_name"].stringValue
    }
}

class AssignmentEditContentModel : NSObject {
    var subject_name = ""
    var teacher_name = ""
    var assignment_id = ""
    var school_id = ""
    var year_id = ""
    var school_grade_id = ""
    var school_level_id = ""
    var school_major_id = ""
    var subject_id = ""
    var chapter_id = ""
    var assignment_type = ""
    var score_type_id = ""
    var note = ""
    var teacher_id = ""
    var assignment_image = ""
    var school_class_list = [AssignmentEditClassContentModel]()
    
    func objectMapping(json: JSON){
        subject_name = json ["subject_name"].stringValue
        teacher_name = json ["teacher_name"].stringValue
        assignment_id = json ["assignment_id"].stringValue
        school_id = json ["school_id"].stringValue
        year_id = json ["year_id"].stringValue
        school_grade_id = json ["school_grade_id"].stringValue
        school_level_id = json ["school_level_id"].stringValue
        school_major_id = json ["school_major_id"].stringValue
        subject_id = json ["subject_id"].stringValue
        chapter_id = json ["chapter_id"].stringValue
        assignment_type = json ["assignment_type"].stringValue
        score_type_id = json ["score_type_id"].stringValue
        note = json ["note"].stringValue
        teacher_id = json ["teacher_id"].stringValue
        assignment_image = json ["assignment_image"].stringValue
        for data in json ["school_class_list"].arrayValue{
            let d = AssignmentEditClassContentModel()
            d.objectMapping(json: data)
            school_class_list.append(d)
        }
    }
}

class AssignmentEditClassContentModel : NSObject {
    var school_class = ""
    var assignment_id = ""
    var school_class_id = ""
    var due_date = ""
    var status = 0
    var score_submit_date = ""
    var class_assign_date = ""
    var school_join_class_id = ""
    
    func objectMapping(json: JSON){
        school_class = json ["school_class"].stringValue
        assignment_id = json ["assignment_id"].stringValue
        school_class_id = json ["school_class_id"].stringValue
        due_date = json ["due_date"].stringValue
        status = json ["status"].intValue
        score_submit_date = json ["score_submit_date"].stringValue
        class_assign_date = json ["class_assign_date"].stringValue
        school_join_class_id = json ["school_join_class_id"].stringValue
    }
}
