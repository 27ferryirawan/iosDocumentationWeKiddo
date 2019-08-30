//
//  TaskListModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 28/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class TaskListModel: NSObject {
    var task_date = ""
    var detail = [TaskListDetailModel]()
    
    func objectMapping(json: JSON) {
        task_date = json["task_date"].stringValue

        for data in json["detail"].arrayValue {
            let d = TaskListDetailModel()
            d.objectMapping(json: data)
            detail.append(d)
        }
    }
}

class TaskListDetailModel: NSObject {
    var title = ""
    var task_date = ""
    var assign_task_id = 0
    var status = 0
    var desc = ""
    var task_id = ""
    
    func objectMapping(json: JSON) {
        title = json["title"].stringValue
        task_date = json["task_date"].stringValue
        assign_task_id = json["assign_task_id"].intValue
        status = json["status"].intValue
        desc = json["description"].stringValue
        task_id = json["task_id"].stringValue
    }

}
