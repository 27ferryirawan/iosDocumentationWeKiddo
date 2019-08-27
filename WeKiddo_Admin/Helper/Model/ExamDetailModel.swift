//
//  ExamDetailModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 08/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ExamDetailModel: NSObject {
    var start_time = ""
    var subject_id = ""
    var chapter_id = ""
    var session_date = ""
    var school_session_exam_id = ""
    var score_type_id = ""
    var chapter_desc = ""
    var chapter_name = ""
    var score_type_name = ""
    var subject_name = ""
    var week_count = 0
    var school_class_id = ""
    var school_class = ""
    var sessions = [ExamDetailSessionsModel]()
    var remedy = [ExamDetailRemedyModel]()
    var related = [ExamDetailRelatedModel]()
    
    func objectMapping(json: JSON) {
        start_time = json["data"]["exam_detail"]["start_time"].stringValue
        subject_id = json["data"]["exam_detail"]["subject_id"].stringValue
        chapter_id = json["data"]["exam_detail"]["chapter_id"].stringValue
        session_date = json["data"]["exam_detail"]["session_date"].stringValue
        school_session_exam_id = json["data"]["exam_detail"]["school_session_exam_id"].stringValue
        score_type_id = json["data"]["exam_detail"]["score_type_id"].stringValue
        chapter_desc = json["data"]["exam_detail"]["chapter_desc"].stringValue
        chapter_name = json["data"]["exam_detail"]["chapter_name"].stringValue
        score_type_name = json["data"]["exam_detail"]["score_type_name"].stringValue
        subject_name = json["data"]["exam_detail"]["subject_name"].stringValue
        week_count = json["data"]["exam_detail"]["week_count"].intValue
        school_class_id = json["data"]["exam_detail"]["school_class_id"].stringValue
        school_class = json["data"]["exam_detail"]["school_class"].stringValue
        for data in json["data"]["exam_detail"]["sessions"].arrayValue {
            let d = ExamDetailSessionsModel()
            d.objectMapping(json: data)
            sessions.append(d)
        }
        for data in json["data"]["exam_detail"]["remedy"].arrayValue {
            let d = ExamDetailRemedyModel()
            d.objectMapping(json: data)
            remedy.append(d)
        }
        for data in json["data"]["exam_detail"]["related"].arrayValue {
            let d = ExamDetailRelatedModel()
            d.objectMapping(json: data)
            related.append(d)
        }
    }
}

class ExamDetailRelatedModel: NSObject {
    var chapter_name = ""
    var session_date = ""
    var subject_id = ""
    var exam_type_name = ""
    var flag_color = 0
    var school_session_exam_id = ""
    
    func objectMapping(json: JSON) {
        chapter_name = json["chapter_name"].stringValue
        session_date = json["session_date"].stringValue
        subject_id = json["subject_id"].stringValue
        exam_type_name = json["exam_type_name"].stringValue
        flag_color = json["flag_color"].intValue
        school_session_exam_id = json["school_session_exam_id"].stringValue
    }
}

class ExamDetailRemedyModel: NSObject {
    var title = ""
    var exam_remedy_id = ""
    var remedy_date = ""
    var students = [StudentsRemedyModel]()
    
    func objectMapping(json: JSON) {
        title = json["title"].stringValue
        exam_remedy_id = json["exam_remedy_id"].stringValue
        remedy_date = json["remedy_date"].stringValue
        for data in json["students"].arrayValue {
            let d = StudentsRemedyModel()
            d.objectMapping(json: data)
            students.append(d)
        }
    }
}

class ExamDetailSessionsModel: NSObject {
    var from_date = ""
    var week_count = ""
    var end_date = ""
    var session_list = [SessionListModel]()
    func objectMapping(json: JSON) {
        from_date = json["from_date"].stringValue
        week_count = json["week_count"].stringValue
        end_date = json["end_date"].stringValue
        for data in json["session_list"].arrayValue {
            let d = SessionListModel()
            d.objectMapping(json: data)
            session_list.append(d)
        }
    }
}

class SessionListModel: NSObject {
    var session_count = 0
    
    func objectMapping(json: JSON) {
        session_count = json["session_count"].intValue
    }
}

class StudentsRemedyModel: NSObject {
    var child_id = ""
    var child_name = ""
    var child_image = ""
    var child_nis = ""
    
    func objectMapping(json: JSON) {
        child_id = json["child_id"].stringValue
        child_name = json["child_name"].stringValue
        child_image = json["child_image"].stringValue
        child_nis = json["child_nis"].stringValue
    }
}
