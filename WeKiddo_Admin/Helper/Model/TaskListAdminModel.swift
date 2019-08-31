//
//  TaskListAdminModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 01/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class TaskListAdminModel: NSObject {
    var title = ""
    var task_date = ""
    var task_id = ""
    
    func objectMapping(json: JSON) {
        title = json["title"].stringValue
        task_date = json["task_date"].stringValue
        task_id = json["task_id"].stringValue
    }
}
