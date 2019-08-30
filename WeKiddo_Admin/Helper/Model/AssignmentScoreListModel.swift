//
//  AssignmentScoreListModel.swift
//  WeKiddo_Admin
//
//  Created by Yosua Hoo on 28/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AssignmentScoreListModel : NSObject {
    var assignment_id = ""
    var subject_id = ""
    var school_class_id = ""
    var subject_name = ""
    var chapter_name = ""
    var student_list = [AssignmentScoreStudentModel]()
    
    func objectMapping(json: JSON){
        assignment_id = json ["assignment_id"].stringValue
        subject_id = json ["subject_id"].stringValue
        school_class_id = json ["school_class_id"].stringValue
        subject_name = json ["subject_name"].stringValue
        chapter_name = json ["chapter_name"].stringValue
        for data in json ["student_list"].arrayValue{
            let d = AssignmentScoreStudentModel()
            d.objectMapping(json: data)
            student_list.append(d)
        }
    }
}

class AssignmentScoreStudentModel : NSObject {
    var child_id = ""
    var child_name = ""
    var child_image = ""
    var score = 0
    
    func objectMapping(json: JSON){
        child_id = json ["child_id"].stringValue
        child_name = json ["child_name"].stringValue
        child_image = json ["child_image"].stringValue
        score = json ["score"].intValue
    }
}
