//
//  TicketPendingModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 03/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class TicketPendingModel: NSObject {
    var ticket_type = 0
    var title = ""
    var ticket_id = ""
    var created_at = ""
    var status = 0
    
    func objectMapping(json:JSON){
        ticket_type = json["ticket_type"].intValue
        title = json["title"].stringValue
        ticket_id = json["ticket_id"].stringValue
        created_at = json["created_at"].stringValue
        status = json["status"].intValue
    }
}
