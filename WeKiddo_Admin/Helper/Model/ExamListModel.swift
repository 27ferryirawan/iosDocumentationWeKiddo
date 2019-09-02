//
//  ExamListModel.swift
//  WeKiddo_Admin
//
//  Created by Yosua Hoo on 31/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ExamListModel : NSObject {
    var examList = [ExamListContentModel]()
    
    func objectMapping(json:JSON){
        for data in json["data"]["exam_list"].arrayValue{
            let d = ExamListContentModel()
            d.objectMapping(json: data)
            examList.append(d)
        }
    }
}

class ExamListContentModel : NSObject {
    var teacher_id = ""
    var teacher_name = ""
    var exams = [ExamContentModel]()
    
    func objectMapping(json:JSON){
        teacher_id = json["teacher_id"].stringValue
        teacher_name = json["teacher_name"].stringValue
        for data in json["exams"].arrayValue{
            let d = ExamContentModel()
            d.objectMapping(json: data)
            exams.append(d)
        }
    }
}

class ExamContentModel : NSObject {
    var school_session_exam_id = ""
    var subject_id = ""
    var exam_title = ""
    var exam_desc = ""
    var score_type_id = ""
    var school_class_id = ""
    var school_class = ""
    var subject_name = ""
    var exam_type_name = ""
    var session_date = ""
    var flag_color = 0
    var start_time = ""
    var session_text = ""
    
    func objectMapping(json : JSON){
        school_session_exam_id = json["school_session_exam_id"].stringValue
        subject_id = json["subject_id"].stringValue
        exam_title = json["exam_title"].stringValue
        exam_desc = json["exam_desc"].stringValue
        score_type_id = json["score_type_id"].stringValue
        school_class_id = json["school_class_id"].stringValue
        school_class = json["school_class"].stringValue
        subject_name = json["subject_name"].stringValue
        exam_type_name = json["exam_type_name"].stringValue
        session_date = json["session_date"].stringValue
        flag_color = json["flag_color"].intValue
        start_time = json["start_time"].stringValue
        session_text = json["session_text"].stringValue
    }
}
