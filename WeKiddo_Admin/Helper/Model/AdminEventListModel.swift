//
//  AdminEventListModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 17/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AdminEventListModel: NSObject {
    var start_event_date = ""
    var target_type = ""
    var count_reject = 0
    var count_total = 0
    var event_id = ""
    var count_pending = 0
    var count_approve = 0
    var target_id = ""
    var event_name = ""
    
    func objectMapping(json: JSON) {
        start_event_date = json["start_event_date"].stringValue
        target_type = json["target_type"].stringValue
        count_reject = json["count_reject"].intValue
        count_total = json["count_total"].intValue
        event_id = json["event_id"].stringValue
        count_pending = json["count_pending"].intValue
        count_approve = json["count_approve"].intValue
        target_id = json["target_id"].stringValue
        event_name = json["event_name"].stringValue        
    }
}
