//
//  SpecialAttentionBySubjectListModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 29/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class SpecialAttentionBySubjectListModel: NSObject {
    var subject_name = ""
    var child_name = ""
    var school_class_id = ""
    var subject_id = ""
    var passing_grade = 0
    var school_class = ""
    var score = ""
    var child_nis = ""
    var score_type_id = ""
    var child_id = ""
    var teacher_name = ""
    
    func objectMapping(json: JSON) {
        subject_name = json["subject_name"].stringValue
        child_name = json["child_name"].stringValue
        school_class_id = json["school_class_id"].stringValue
        subject_id = json["subject_id"].stringValue
        passing_grade = json["passing_grade"].intValue
        school_class = json["school_class"].stringValue
        score = json["score"].stringValue
        child_nis = json["child_nis"].stringValue
        score_type_id = json["score_type_id"].stringValue
        child_id = json["child_id"].stringValue
        teacher_name = json["teacher_name"].stringValue
    }
}

