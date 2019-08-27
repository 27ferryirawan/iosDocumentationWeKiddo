//
//  ApprovalModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 04/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ApprovalModel: NSObject {
    var event_id = ""
    var event_name = ""
    var event_media = ""
    var start_event_date = ""
    var end_event_date = ""
    var event_due_date = ""
    var amount = ""
    var desc = ""
    var event_latlong = ""
    var school_level_id = ""
    var school_class_id = ""
    var is_approved = ""
    
    func objectMapping(json: JSON) {
        event_id = json["event_id"].stringValue
        event_name = json["event_name"].stringValue
        event_media = json["event_media"].stringValue
        start_event_date = json["start_event_date"].stringValue
        end_event_date = json["end_event_date"].stringValue
        event_due_date = json["event_due_date"].stringValue
        amount = json["amount"].stringValue
        desc = json["desc"].stringValue
        event_latlong = json["event_latlong"].stringValue
        start_event_date = json["start_event_date"].stringValue
        school_level_id = json["school_level_id"].stringValue
        school_class_id = json["school_class_id"].stringValue
        is_approved = json["is_approved"].stringValue
    }
}
