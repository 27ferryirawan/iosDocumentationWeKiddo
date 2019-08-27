//
//  CurrentClassListModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 02/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class CurrentClassListModel: NSObject {
    var firstPageUrl = ""
    var from = 0
    var perPage = 0
    var prevPageUrl = ""
    var currentPage = 0
    var to = 0
    var path = ""
    var nextPageurl = ""
    var sessionData = [CurrentClassListSessionModel]()
    
    func objectMapping(json: JSON) {
        firstPageUrl = json["data"]["current_class_list"]["first_page_url"].stringValue
        for data in json["data"]["current_class_list"]["data"].arrayValue {
            let d = CurrentClassListSessionModel()
            d.objectMapping(json: data)
            sessionData.append(d)
        }
    }
}

class CurrentClassListSessionModel: NSObject {
    var dateForHuman = ""
    var session_date = ""
    var subject_id = ""
    var subject_name = ""
    var school_class_id = ""
    var chapter_name = ""
    var end_time = ""
    var week_count = 0
    var school_session_id = ""
    var school_class = ""
    var chapter_id = ""
    var chapter_desc = ""
    var start_time = ""
    var is_join_class = Bool()
    var session_count = 0
    var students = [CurrentClassListSessionStudentModel]()
    
    func objectMapping(json: JSON) {
        dateForHuman = json["dateForHuman"].stringValue
        session_date = json["session_date"].stringValue
        chapter_desc = json["chapter_desc"].stringValue
        chapter_name = json["chapter_name"].stringValue
        school_class = json["school_class"].stringValue
        chapter_id = json["chapter_id"].stringValue
        start_time = json["start_time"].stringValue
        school_session_id = json["school_session_id"].stringValue
        school_class_id = json["school_class_id"].stringValue
        is_join_class = json["is_join_class"].boolValue
        session_count = json["session_count"].intValue
        subject_id = json["subject_id"].stringValue
        end_time = json["end_time"].stringValue
        session_date = json["session_date"].stringValue
        subject_name = json["subject_name"].stringValue
        week_count = json["week_count"].intValue

        for data in json["students"].arrayValue {
            let d = CurrentClassListSessionStudentModel()
            d.objectMapping(json: data)
            students.append(d)
        }
    }
}

class CurrentClassListSessionStudentModel: NSObject {
    var child_image = ""
    var child_id = ""
    var child_name = ""
    var is_attend = 0
    var child_nis = ""
    
    func objectMapping(json: JSON) {
        child_image = json["child_image"].stringValue
        child_id = json["child_id"].stringValue
        child_name = json["child_name"].stringValue
        is_attend = json["is_attend"].intValue
        child_nis = json["child_nis"].stringValue
    }
}
