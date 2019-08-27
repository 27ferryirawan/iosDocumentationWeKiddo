//
//  ExamMajorModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 26/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ExamMajorModel: NSObject {
    var exam_major = [ExamMajorListModel]()
    var exam_class = [ExamClassListModel]()
    var week_session = [ExamClassWeekSessionModel]()
    
    func objectMapping(json: JSON) {
        for data in json["data"]["list"]["class"].arrayValue {
            let d = ExamClassListModel()
            d.objectMapping(json: data)
            exam_class.append(d)
        }
        for data in json["data"]["list"]["major"].arrayValue {
            let d = ExamMajorListModel()
            d.objectMapping(json: data)
            exam_major.append(d)
        }
        for data in json["data"]["list"]["week_session"].arrayValue {
            let d = ExamClassWeekSessionModel()
            d.objectMapping(json: data)
            week_session.append(d)
        }
    }
}

class ExamMajorListModel: NSObject {
    var school_major_id = ""
    var school_major = ""
    
    func objectMapping(json: JSON) {
        school_major_id = json["school_major_id"].stringValue
        school_major = json["school_major"].stringValue
    }
}

class ExamClassListModel: NSObject {
    var school_class_id = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        school_class_id = json["school_class_id"].stringValue
        school_class = json["school_class"].stringValue
    }
}

class ExamClassWeekSessionModel: NSObject {
    var week_count = 0
    var from_date = ""
    var end_date = ""
    var sessions = [ExamClassSessionModel]()
    
    func objectMapping(json: JSON) {
        week_count = json["week_count"].intValue
        from_date = json["from_date"].stringValue
        end_date = json["end_date"].stringValue
        for data in json["sessions"].arrayValue {
            let d = ExamClassSessionModel()
            d.objectMapping(json: data)
            sessions.append(d)
        }
    }
}

class ExamClassSessionModel: NSObject {
    var session_count = 0
    
    func objectMapping(json: JSON) {
        session_count = json["session_count"].intValue
    }
}

class ExamSessionSelectedModel: NSObject {
    var weekAt = 0
    var sessionAt = 0
    
    init(weekAt: Int, sessionAt: Int) {
        self.weekAt = weekAt
        self.sessionAt = sessionAt
    }
}
