//
//  UsersListsModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 07/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class UsersListsModel : NSObject {
    
    var admin_pos_id = ""
    var admin_pos_name = ""
    var members = [UsersListsMemberModel]()
    
    func objectMapping(json : JSON){
        admin_pos_id = json["admin_pos_id"].stringValue
        admin_pos_name = json["admin_pos_name"].stringValue
        for data in json["members"].arrayValue{
            let d = UsersListsMemberModel()
            d.objectMapping(json: data)
            members.append(d)
        }
    }
}

class UsersListsMemberModel: NSObject {
    var name = ""
    var admin_photo = ""
    var admin_id = ""
    
    func objectMapping(json : JSON){
        name = json["name"].stringValue
        admin_photo = json["admin_photo"].stringValue
        admin_id = json["admin_id"].stringValue
    }
}
