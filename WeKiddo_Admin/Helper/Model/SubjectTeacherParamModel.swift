//
//  SubjectTeacherParamModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 20/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class SubjectTeacherParamModel: NSObject {
    var week_session = [SubjectTeacherParamWeekSessionModel]()
    var class_param = [SubjectTeacherParamClassModel]()
    var exam_type_list = [SubjectTeacherParamExamTypeModel]()
    
    func objectMapping(json: JSON) {
        for data in json["data"]["params"]["week_session"].arrayValue {
            let d = SubjectTeacherParamWeekSessionModel()
            d.objectMapping(json: data)
            week_session.append(d)
        }
        for data in json["data"]["params"]["class_param"].arrayValue {
            let d = SubjectTeacherParamClassModel()
            d.objectMapping(json: data)
            class_param.append(d)
        }
        for data in json["data"]["params"]["exam_type_list"].arrayValue {
            let d = SubjectTeacherParamExamTypeModel()
            d.objectMapping(json: data)
            exam_type_list.append(d)
        }
    }
}

class SubjectTeacherParamExamTypeModel: NSObject {
    var exam_type_id = ""
    var exam_type_name = ""
    
    func objectMapping(json: JSON) {
        exam_type_id = json["exam_type_id"].stringValue
        exam_type_name = json["exam_type_name"].stringValue
    }
}

class SubjectTeacherParamClassModel: NSObject {
    var school_class = ""
    var school_class_id = ""
    
    func objectMapping(json: JSON) {
        school_class = json["school_class"].stringValue
        school_class_id = json["school_class_id"].stringValue
    }
}

class SubjectTeacherParamWeekSessionModel: NSObject {
    var week_count = 0
    var from_date = ""
    var end_date = ""
    var sessions = [SubjectTeacherParamWeekSessionsSessionModel]()
    
    func objectMapping(json: JSON) {
        week_count = json["week_count"].intValue
        from_date = json["from_date"].stringValue
        end_date = json["end_date"].stringValue
        for data in json["sessions"].arrayValue {
            let d = SubjectTeacherParamWeekSessionsSessionModel()
            d.objectMapping(json: data)
            sessions.append(d)
        }
    }
}

class SubjectTeacherParamWeekSessionsSessionModel: NSObject {
    var session_count = 0
    
    func objectMapping(json: JSON) {
        session_count = json["session_count"].intValue
    }
}

class SubjectTeacherParamClassSelectedModel: Codable {
    var school_class_name = ""
    var school_class_id = ""
    
    init(schoolClassName: String, schoolClassID: String) {
        self.school_class_id = schoolClassID
        self.school_class_name = schoolClassName
    }
}

class SubjectTeacherAttachmentArrayModel: NSObject {
    var media_id = ""
    var media_url = ""
    var media_type_id = ""
    var attach_title = ""
    
    func objectMapping(json: JSON) {
        media_id = json["data"]["media_file"]["id"].stringValue
        media_url = json["data"]["media_file"]["url"].stringValue
        attach_title = json["data"]["attach_title"].stringValue
        media_type_id = json["data"]["media_file"]["media_type_id"].stringValue
    }
}

class SubjectTeacherVoiceNotesArrayModel: NSObject {
    var media_id = ""
    var media_url = ""
    var media_type_id = ""
    var attach_title = ""
    
    func objectMapping(json: JSON) {
        media_id = json["data"]["media_file"]["id"].stringValue
        media_url = json["data"]["media_file"]["url"].stringValue
        attach_title = json["data"]["attach_title"].stringValue
        media_type_id = json["data"]["media_file"]["media_type_id"].stringValue
    }
}

class SubjectTeacherSessionSelectedModel: NSObject {
    var sectionAt = 0
    var indexAt = 0
    var valueAt = ""
    
    init(sectionAt: Int, indexAt: Int, valueAt: String) {
        self.sectionAt = sectionAt
        self.indexAt = indexAt
        self.valueAt = valueAt
    }
}
