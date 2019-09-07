//
//  UsersDetailModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 08/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class UsersDetailModel: NSObject {
    var user_position_list = [UsersDetailPositionModel]()
    var user_acl_list = [UsersDetailACLModel]()
    var user_detail_phone = ""
    var user_detail_address = ""
    var user_detail_email = ""
    var user_detail_adminPhoto = ""
    var user_detail_name = ""
    var user_detail_gender = ""
    var user_detail_assigned = [UsersDetailAssignmentModel]()
    
    func objectMapping(json : JSON){
        for data in json["data"]["info"]["position_list"].arrayValue{
            let d = UsersDetailPositionModel()
            d.objectMapping(json: data)
            user_position_list.append(d)
        }
        for data in json["data"]["info"]["acl_list"].arrayValue{
            let d = UsersDetailACLModel()
            d.objectMapping(json: data)
            user_acl_list.append(d)
        }
        for data in json["data"]["info"]["user_detail"]["assigned"].arrayValue{
            let d = UsersDetailAssignmentModel()
            d.objectMapping(json: data)
            user_detail_assigned.append(d)
        }
    }
}

class UsersDetailPositionModel: NSObject {
    var admin_pos_name = ""
    var admin_pos_id = ""
    var is_selected = Bool()
    
    func objectMapping(json : JSON){
        admin_pos_name = json["admin_pos_name"].stringValue
        admin_pos_id = json["admin_pos_id"].stringValue
        is_selected = json["is_selected"].boolValue
    }
}

class UsersDetailACLModel: NSObject {
    var group_acl_id = ""
    var desc_acl = ""
    var is_selected = Bool()
    
    func objectMapping(json : JSON){
        group_acl_id = json["group_acl_id"].stringValue
        desc_acl = json["desc_acl"].stringValue
        is_selected = json["is_selected"].boolValue
    }
}

class UsersDetailAssignmentModel: NSObject {
    var group_acl_id = ""
    var desc_acl = ""
    var is_selected = Bool()
    
    func objectMapping(json : JSON){
        group_acl_id = json["group_acl_id"].stringValue
        desc_acl = json["desc_acl"].stringValue
        is_selected = json["is_selected"].boolValue
    }
}
