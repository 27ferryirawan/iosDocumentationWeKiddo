//
//  UserListModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 06/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserListModel : NSObject {
    
    var role_id = ""
    var role_name = ""
    var members = [UserListMemberModel]()
    
    func objectMapping(json : JSON){
        role_id = json["role_id"].stringValue
        role_name = json["role_name"].stringValue
        for data in json["members"].arrayValue{
            let d = UserListMemberModel()
            d.objectMapping(json: data)
            members.append(d)
        }
    }
}

class UserListMemberModel: NSObject {
    var teacher_id = ""
    var teacher_name = ""
    var teacher_image = ""
    var nuptk = ""
    
    func objectMapping(json : JSON){
        teacher_id = json["teacher_id"].stringValue
        teacher_name = json["teacher_name"].stringValue
        teacher_image = json["teacher_image"].stringValue
        nuptk = json["nuptk"].stringValue
    }
}
