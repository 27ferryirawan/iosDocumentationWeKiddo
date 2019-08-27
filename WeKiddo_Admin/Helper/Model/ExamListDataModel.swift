//
//  ExamListDataModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 09/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ExamListDataModel: NSObject {
    var exam_level_list = [ExamListLevelDataModel]()
    var exam_subject_list = [ExamListSubjectDataModel]()
    var exam_list = [ExamListExamModel]()
    
    func objectMapping(json: JSON) {
        for data in json["data"]["exam_list"]["level_list"].arrayValue {
            let d = ExamListLevelDataModel()
            d.objectMapping(json: data)
            exam_level_list.append(d)
        }
        for data in json["data"]["exam_list"]["exam_list"].arrayValue {
            let d = ExamListExamModel()
            d.objectMapping(json: data)
            exam_list.append(d)
        }
        for data in json["data"]["exam_list"]["subject_list"].arrayValue {
            let d = ExamListSubjectDataModel()
            d.objectMapping(json: data)
            exam_subject_list.append(d)
        }
    }
}

class ExamListLevelDataModel: NSObject {
    var school_level = ""
    var school_level_id = ""
    
    func objectMapping(json: JSON) {
        school_level = json["school_level"].stringValue
        school_level_id = json["school_level_id"].stringValue
    }
}

class ExamListExamModel: NSObject {
    var session_count = ""
    var chapter_name = ""
    var session_date = ""
    var score_type_id = ""
    var score_type_name = ""
    var school_class = ""
    var start_time = ""
    var subject_name = ""
    var chapter_id = ""
    var subject_id = ""
    var school_class_id = ""
    var school_session_exam_id = ""

    func objectMapping(json: JSON) {
        session_count = json["session_count"].stringValue
        chapter_name = json["chapter_name"].stringValue
        session_date = json["session_date"].stringValue
        score_type_id = json["score_type_id"].stringValue
        score_type_name = json["score_type_name"].stringValue
        school_class = json["school_class"].stringValue
        start_time = json["start_time"].stringValue
        subject_name = json["subject_name"].stringValue
        chapter_id = json["chapter_id"].stringValue
        subject_id = json["subject_id"].stringValue
        school_class_id = json["school_class_id"].stringValue
        school_session_exam_id = json["school_session_exam_id"].stringValue
    }
}

class ExamListSubjectDataModel: NSObject {
    var subject_name = ""
    var subject_id = ""
    
    func objectMapping(json: JSON) {
        subject_name = json["subject_name"].stringValue
        subject_id = json["subject_id"].stringValue
    }
}
