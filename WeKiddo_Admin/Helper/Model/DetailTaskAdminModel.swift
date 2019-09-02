//
//  DetailTaskAdminModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 02/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class DetailTaskAdminModel : NSObject {
    var task_date = ""
    var title = ""
    var assigne_admin = [DetailTaskAdminAssigneeModel]()
    
    func objectMapping(json:JSON){
        task_date = json["data"]["detail_task"]["task_date"].stringValue
        title = json["data"]["detail_task"]["title"].stringValue
        for data in json["data"]["detail_task"]["assign_admin"].arrayValue{
            let d = DetailTaskAdminAssigneeModel()
            d.objectMapping(json: data)
            assigne_admin.append(d)
        }
    }
}

class DetailTaskAdminAssigneeModel: NSObject {
    var admin_pos_name = ""
    var admin_pos_id = ""
    var member = [DetailTaskAdminAssigneeMemberModel]()
    
    func objectMapping(json:JSON){
        admin_pos_name = json["admin_pos_name"].stringValue
        admin_pos_id = json["admin_pos_id"].stringValue
        for data in json["member"].arrayValue{
            let d = DetailTaskAdminAssigneeMemberModel()
            d.objectMapping(json: data)
            member.append(d)
        }
    }
}

class DetailTaskAdminAssigneeMemberModel: NSObject {
    var admin_pos_name = ""
    var admin_pos_id = ""
    var admin_id = ""
    var status = Bool()
    
    func objectMapping(json:JSON){
        admin_pos_name = json["admin_pos_name"].stringValue
        admin_pos_id = json["admin_pos_id"].stringValue
        admin_id = json["admin_id"].stringValue
        status = json["status"].boolValue
    }
}
