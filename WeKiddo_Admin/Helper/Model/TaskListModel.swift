//
//  TaskListModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 28/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class TaskListModel: NSObject {
    var passing_grade = ""
    var score = ""
    var child_nis = ""
    var subject_id = ""
    var score_type_id = ""
    var teacher_name = ""
    var school_class = ""
    var subject_name = ""
    var radian_score = ""
    var school_class_id = ""
    var child_id = ""
    var child_name = ""
    var score_list = [SpecialAttentionBySubjectDetailScoreListModel]()
    
    func objectMapping(json: JSON) {
        passing_grade = json["data"]["failed_score_detail"]["passing_grade"].stringValue
        score = json["data"]["failed_score_detail"]["score"].stringValue
        child_nis = json["data"]["failed_score_detail"]["child_nis"].stringValue
        subject_id = json["data"]["failed_score_detail"]["subject_id"].stringValue
        score_type_id = json["data"]["failed_score_detail"]["score_type_id"].stringValue
        teacher_name = json["data"]["failed_score_detail"]["teacher_name"].stringValue
        school_class = json["data"]["failed_score_detail"]["school_class"].stringValue
        subject_name = json["data"]["failed_score_detail"]["subject_name"].stringValue
        radian_score = json["data"]["failed_score_detail"]["radian_score"].stringValue
        school_class_id = json["data"]["failed_score_detail"]["school_class_id"].stringValue
        child_id = json["data"]["failed_score_detail"]["child_id"].stringValue
        child_name = json["data"]["failed_score_detail"]["child_name"].stringValue
        for data in json["data"]["failed_score_detail"]["score_list"].arrayValue {
            let d = SpecialAttentionBySubjectDetailScoreListModel()
            d.objectMapping(json: data)
            score_list.append(d)
        }
    }
}
