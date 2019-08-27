//
//  UpcomingSessionListModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 16/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class UpcomingSessionListModel: NSObject {
    var session_date = ""
    var dateForHuman = ""
    var session_item = [UpcomingSessionItem]()
    
    func objectMapping(json: JSON) {
        session_date = json["session_date"].stringValue
        dateForHuman = json["dateForHuman"].stringValue
        
        for data in json["session_item"].arrayValue {
            let d = UpcomingSessionItem()
            d.objectMapping(json: data)
            session_item.append(d)
        }
    }
}

class UpcomingSessionItem: NSObject {
    var subject_name = ""
    var school_session_id = ""
    var end_time = ""
    var week_count = 0
    var session_count = 0
    var school_class = ""
    var session_date = ""
    var start_time = ""
    var school_class_id = ""
    var subject_id = ""
    
    func objectMapping(json: JSON) {
        subject_name = json["subject_name"].stringValue
        school_session_id = json["school_session_id"].stringValue
        end_time = json["end_time"].stringValue
        week_count = json["week_count"].intValue
        session_count = json["session_count"].intValue
        school_class = json["school_class"].stringValue
        session_date = json["session_date"].stringValue
        start_time = json["start_time"].stringValue
        school_class_id = json["school_class_id"].stringValue
        subject_id = json["subject_id"].stringValue
        school_class_id = json["school_class_id"].stringValue
    }
}
