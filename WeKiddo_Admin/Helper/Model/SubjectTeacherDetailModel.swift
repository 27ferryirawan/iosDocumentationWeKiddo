//
//  SubjectTeacherDetailModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 02/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class SubjectTeacherDetailModel: NSObject {
    var school_level = ""
    var exam_type_name = ""
    var chapter_desc = ""
    var chapter_name = ""
    var exam_desc = ""
    var exam_type_id = ""
    var subject_name = ""
    var school_level_id = ""
    var chapter_id = ""
    var subject_id = ""
    var school_exam_id = ""
    var is_exam = Bool()
    var subject_chapter_session_details = [SubjectTeacherDetailSessionDetailModel]()
    var subject_chapter_medias = [SubjectTeacherDetailMediasModel]()
    var subject_chapter_classes = [SubjectTeacherDetailClassesModel]()
    var subject_chapter_detail_session_week = [SubjectTeacherDetailSessionWeekModel]()
    
    func objectMapping(json: JSON) {
        school_level = json["data"]["topic_detail"]["school_level"].stringValue
        exam_type_id = json["data"]["topic_detail"]["exam_type_id"].stringValue
        subject_id = json["data"]["topic_detail"]["subject_id"].stringValue
        exam_type_name = json["data"]["topic_detail"]["exam_type_name"].stringValue
        chapter_desc = json["data"]["topic_detail"]["chapter_desc"].stringValue
        chapter_name = json["data"]["topic_detail"]["chapter_name"].stringValue
        exam_desc = json["data"]["topic_detail"]["exam_desc"].stringValue
        subject_name = json["data"]["topic_detail"]["subject_name"].stringValue
        school_level_id = json["data"]["topic_detail"]["school_level_id"].stringValue
        chapter_id = json["data"]["topic_detail"]["chapter_id"].stringValue
        school_exam_id = json["data"]["topic_detail"]["school_exam_id"].stringValue
        is_exam = json["data"]["topic_detail"]["is_exam"].boolValue
        for data in json["data"]["topic_detail"]["subject_chapter_session_details"].arrayValue {
            let d = SubjectTeacherDetailSessionDetailModel()
            d.objectMapping(json: data)
            subject_chapter_session_details.append(d)
        }
        for data in json["data"]["topic_detail"]["medias"].arrayValue {
            let d = SubjectTeacherDetailMediasModel()
            d.objectMapping(json: data)
            subject_chapter_medias.append(d)
        }
        for data in json["data"]["topic_detail"]["classes"].arrayValue {
            let d = SubjectTeacherDetailClassesModel()
            d.objectMapping(json: data)
            subject_chapter_classes.append(d)
        }
        for data in json["data"]["topic_detail"]["session_week"].arrayValue {
            let d = SubjectTeacherDetailSessionWeekModel()
            d.objectMapping(json: data)
            subject_chapter_detail_session_week.append(d)
        }
    }
}

class SubjectTeacherDetailSessionWeekModel: NSObject {
    var from_date = ""
    var sessions = [SubjectTeacherDetailSessionWeekSessionListModel]()
    var end_date = ""
    var week_count = 0
    
    func objectMapping(json: JSON) {
        from_date = json["from_date"].stringValue
        end_date = json["end_date"].stringValue
        week_count = json["week_count"].intValue
        for data in json["sessions"].arrayValue {
            let d = SubjectTeacherDetailSessionWeekSessionListModel()
            d.objectMapping(json: data)
            sessions.append(d)
        }
    }
}

class SubjectTeacherDetailSessionWeekSessionListModel: NSObject {
    var session_count = 0
    var is_checked = Bool()
    var week_count = 0
    
    func objectMapping(json: JSON) {
        session_count = json["session_count"].intValue
        week_count = json["week_count"].intValue
        is_checked = json["is_checked"].boolValue
    }
}

class SubjectTeacherDetailSessionDetailModel: NSObject {
    var school_class = ""
    var chapter_id = ""
    var week_count = 0
    var session_count = 0
    var from_date = ""
    var school_session_id = ""
    var school_class_id = ""
    var end_date = ""
    
    func objectMapping(json: JSON) {
        school_class = json["school_class"].stringValue
        chapter_id = json["chapter_id"].stringValue
        week_count = json["week_count"].intValue
        session_count = json["session_count"].intValue
        from_date = json["from_date"].stringValue
        school_session_id = json["school_session_id"].stringValue
        school_class_id = json["school_class_id"].stringValue
        end_date = json["end_date"].stringValue
    }
}

class SubjectTeacherDetailMediasModel: NSObject {
    var url = ""
    var media_type_id = ""
    var media_id = 0

    func objectMapping(json: JSON) {
        url = json["url"].stringValue
        media_type_id = json["media_type_id"].stringValue
        media_id = json["media_id"].intValue
    }
}

class SubjectTeacherDetailClassesModel: NSObject {
    var school_class_id = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        school_class_id = json["school_class_id"].stringValue
        school_class = json["school_class"].stringValue
    }
}
