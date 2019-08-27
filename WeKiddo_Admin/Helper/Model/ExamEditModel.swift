//
//  ExamEditModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 25/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ExamEditModel: NSObject {
    var created_at = ""
    var teacher_id = ""
    var school_id = ""
    var exam_desc = ""
    var exam_title = ""
    var year_id = ""
    var exam_type_id = ""
    var updated_at = ""
    var school_session_exam_id = ""
    var score_type_id = ""
    var status = Bool()
    var sessionWeek = [ExamEditSessionWeekModel]()
    var examRelated = [ExamEditExamRelatedModel]()
    var examRemedy = [ExamEditExamRemedyModel]()
    var examClass = [ExamEditClassModel]()
    var school_grade_id = ""
    var school_major_id = ""
    var school_class = ""
    var subject_name = ""
    var school_class_id = ""
    var school_major = ""
    var school_grade = ""
    var school_level = ""
    var school_level_id = ""
    var subject_id = ""

    func objectMapping(json: JSON) {
        created_at = json["data"]["exam_edit"]["exam_detail"]["created_at"].stringValue
        subject_id = json["data"]["exam_edit"]["extra"]["subject_id"].stringValue
        teacher_id = json["data"]["exam_edit"]["exam_detail"]["teacher_id"].stringValue
        school_id = json["data"]["exam_edit"]["exam_detail"]["school_id"].stringValue
        exam_desc = json["data"]["exam_edit"]["exam_detail"]["exam_desc"].stringValue
        exam_title = json["data"]["exam_edit"]["exam_detail"]["exam_title"].stringValue
        year_id = json["data"]["exam_edit"]["exam_detail"]["year_id"].stringValue
        subject_name = json["data"]["exam_edit"]["extra"]["subject_name"].stringValue
//        exam_type_id = json["data"]["exam_edit"]["exam_detail"]["exam_type_id"].stringValue
        updated_at = json["data"]["exam_edit"]["exam_detail"]["updated_at"].stringValue
        school_session_exam_id = json["data"]["exam_edit"]["exam_detail"]["school_session_exam_id"].stringValue
        score_type_id = json["data"]["exam_edit"]["exam_detail"]["score_type_id"].stringValue
        status = json["data"]["exam_edit"]["exam_detail"]["status"].boolValue
        school_grade_id = json["data"]["exam_edit"]["extra"]["school_grade_id"].stringValue
        school_major_id = json["data"]["exam_edit"]["extra"]["school_major_id"].stringValue
        school_class = json["data"]["exam_edit"]["extra"]["school_class"].stringValue
        school_class_id = json["data"]["exam_edit"]["extra"]["school_class_id"].stringValue
        school_major = json["data"]["exam_edit"]["extra"]["school_major"].stringValue
        school_grade = json["data"]["exam_edit"]["extra"]["school_grade"].stringValue
        school_level = json["data"]["exam_edit"]["extra"]["school_level"].stringValue
        school_level_id = json["data"]["exam_edit"]["extra"]["school_level_id"].stringValue
        exam_type_id = json["data"]["exam_edit"]["extra"]["exam_type_id"].stringValue
        for data in json["data"]["exam_edit"]["week"].arrayValue {
            let d = ExamEditSessionWeekModel()
            d.objectMapping(json: data)
            sessionWeek.append(d)
        }
        for data in json["data"]["exam_edit"]["related"].arrayValue {
            let d = ExamEditExamRelatedModel()
            d.objectMapping(json: data)
            examRelated.append(d)
        }
        for data in json["data"]["exam_edit"]["remedy"].arrayValue {
            let d = ExamEditExamRemedyModel()
            d.objectMapping(json: data)
            examRemedy.append(d)
        }
        for data in json["data"]["exam_edit"]["class"].arrayValue {
            let d = ExamEditClassModel()
            d.objectMapping(json: data)
            examClass.append(d)
        }
    }
}

class ExamEditClassModel: NSObject {
    var school_class_id = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        school_class_id = json["school_class_id"].stringValue
        school_class = json["school_class"].stringValue
    }
}

class ExamEditExamRemedyModel: NSObject {
    var title = ""
    var remarks = ""
    var remedy_date = ""
    var school_session_exam_id = ""
    var exam_remedy_id = ""
    
    func objectMapping(json: JSON) {
        title = json["title"].stringValue
        remarks = json["remarks"].stringValue
        remedy_date = json["remedy_date"].stringValue
        school_session_exam_id = json["school_session_exam_id"].stringValue
        exam_remedy_id = json["exam_remedy_id"].stringValue
    }
}

class ExamEditExamRelatedModel: NSObject {
    var session_date = ""
    var school_session_exam_id = ""
    var exam_type_name = ""
    var chapter_name = ""
    var subject_id = ""
    var flag_color = 0

    func objectMapping(json: JSON) {
        session_date = json["session_date"].stringValue
        school_session_exam_id = json["school_session_exam_id"].stringValue
        exam_type_name = json["exam_type_name"].stringValue
        chapter_name = json["chapter_name"].stringValue
        subject_id = json["subject_id"].stringValue
        flag_color = json["flag_color"].intValue
    }
}

class ExamEditSessionWeekModel: NSObject {
    var end_date = ""
    var from_date = ""
    var week_count = 0
    var sessions = [ExamEditSessionModel]()

    func objectMapping(json: JSON) {
        end_date = json["end_date"].stringValue
        from_date = json["from_date"].stringValue
        week_count = json["week_count"].intValue
        for data in json["sessions"].arrayValue {
            let d = ExamEditSessionModel()
            d.objectMapping(json: data)
            sessions.append(d)
        }
    }
}

class ExamEditSessionModel: NSObject {
    var session_count = 0
    var is_checked = Bool()
    
    func objectMapping(json: JSON) {
        session_count = json["session_count"].intValue
        is_checked = json["is_checked"].boolValue
    }
}

class ExamSessionWeekSelectedModel: NSObject {
    var session_count = 0
    var is_checked = Bool()
    var week_count = 0
    
    init(sessionCount: Int, isChecked: Bool, weekCount: Int) {
        self.session_count = sessionCount
        self.is_checked = isChecked
        self.week_count = weekCount
    }
}
