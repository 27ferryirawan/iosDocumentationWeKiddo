//
//  NotificationModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 03/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class NotificationModel: NSObject {
    var notification_target_id = ""
    var notification_type = ""
    var notification_id = ""
    var created_at = ""

    func objectMapping(json: JSON) {
        notification_target_id = json["notification_target_id"].stringValue
        notification_type = json["notification_type"].stringValue
        notification_id = json["notification_id"].stringValue
        created_at = json["created_at"].stringValue
    }
}
