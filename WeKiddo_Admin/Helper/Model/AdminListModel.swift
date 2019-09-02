//
//  AdminListModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 02/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AdminListModel : NSObject {
    var admin_pos_name = ""
    var admin_pos_id = ""
    var admin_member = [AdminListMemberModel]()
    
    func objectMapping(json:JSON){
        admin_pos_name = json["admin_pos_name"].stringValue
        admin_pos_id = json["admin_pos_id"].stringValue
        for data in json["member"].arrayValue{
            let d = AdminListMemberModel()
            d.objectMapping(json: data)
            admin_member.append(d)
        }
    }
}

class AdminListMemberModel : NSObject {
    var admin_id = ""
    var admin_name = ""
    
    func objectMapping(json:JSON){
        admin_id = json["admin_id"].stringValue
        admin_name = json["name"].stringValue
    }
}

class SelectedAdminListMemberModel : NSObject {
    var group_At = ""
    var member_At = ""
    
    init(groupAt: String, memberAt: String) {
        self.group_At = groupAt
        self.member_At = memberAt
    }
}

