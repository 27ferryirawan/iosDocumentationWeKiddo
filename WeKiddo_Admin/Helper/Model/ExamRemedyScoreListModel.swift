//
//  ExamRemedyScoreListModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 24/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ExamRemedyScoreListModel: NSObject {
    var radiant = 0
    var school_class = ""
    var chapter_id = ""
    var chapter_name = ""
    var school_session_exam_id = ""
    var subject_name = ""
    var passing_grade = ""
    var school_class_id = ""
    var subject_id = ""
    var student_list = [ScoreListStudentListModel]()
    
    func objectMapping(json: JSON) {
        radiant = json["data"]["score_list"]["radiant"].intValue
        school_class = json["data"]["score_list"]["school_class"].stringValue
        chapter_id = json["data"]["score_list"]["chapter_id"].stringValue
        chapter_name = json["data"]["score_list"]["chapter_name"].stringValue
        school_session_exam_id = json["data"]["score_list"]["school_session_exam_id"].stringValue
        subject_name = json["data"]["score_list"]["subject_name"].stringValue
        passing_grade = json["data"]["score_list"]["passing_grade"].stringValue
        school_class_id = json["data"]["score_list"]["school_class_id"].stringValue
        subject_id = json["data"]["score_list"]["subject_id"].stringValue
        for data in json["data"]["score_list"]["student_list"].arrayValue {
            let d = ScoreListStudentListModel()
            d.objectMapping(json: data)
            student_list.append(d)
        }
    }
}

class ScoreListStudentListModel: NSObject {
    var child_id = ""
    var child_name = ""
    var child_image = ""
    var child_nis = ""
    var school_class = ""
    var exam_remedy_id = ""
    var remedy_score = 0
    var exam_score = 0
    
    func objectMapping(json: JSON) {
        exam_remedy_id = json["exam_remedy_id"].stringValue
        child_id = json["child_id"].stringValue
        child_name = json["child_name"].stringValue
        child_image = json["child_image"].stringValue
        child_nis = json["child_nis"].stringValue
        school_class = json["school_class"].stringValue
        remedy_score = json["remedy_score"].intValue
        exam_score = json["exam_score"].intValue
    }
}
