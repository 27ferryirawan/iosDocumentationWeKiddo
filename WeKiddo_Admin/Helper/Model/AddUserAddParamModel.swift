//
//  AddUserAddParamModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 06/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AddUserAddParamModel : NSObject {
    
    var position_list = [AddUserAddParamPositionModel]()
    var subject_list = [AddUserAddParamSubjectModel]()
    var class_list = [AddUserAddParamClassModel]()
    
    func objectMapping(json : JSON){

        for data in json["data"]["param_list"]["position_list"].arrayValue{
            let d = AddUserAddParamPositionModel()
            d.objectMapping(json: data)
            position_list.append(d)
        }
        for data in json["data"]["param_list"]["subject_list"].arrayValue{
            let d = AddUserAddParamSubjectModel()
            d.objectMapping(json: data)
            subject_list.append(d)
        }
        for data in json["data"]["param_list"]["class_list"].arrayValue{
            let d = AddUserAddParamClassModel()
            d.objectMapping(json: data)
            class_list.append(d)
        }

    }
}

class AddUserAddParamClassModel: NSObject {
    var school_class = ""
    var school_class_id = ""
    
    func objectMapping(json : JSON){
        school_class = json["school_class"].stringValue
        school_class_id = json["school_class_id"].stringValue
    }
}

class AddUserAddParamPositionModel: NSObject {
    var role_id = 0
    var role_name = ""
    
    func objectMapping(json : JSON){
        role_id = json["role_id"].intValue
        role_name = json["role_name"].stringValue
    }
}

class AddUserAddParamSubjectModel: NSObject {
    var subject_id = ""
    var subject_name = ""
    
    func objectMapping(json : JSON){
        subject_id = json["subject_id"].stringValue
        subject_name = json["subject_name"].stringValue
    }
}


class AddUserParamModel: NSObject {
    var user_position_list = [AddUserPositionModel]()
    var user_acl_list = [AddUserACLModel]()

    func objectMapping(json : JSON){
        for data in json["data"]["param_list"]["position_list"].arrayValue{
            let d = AddUserPositionModel()
            d.objectMapping(json: data)
            user_position_list.append(d)
        }
        for data in json["data"]["param_list"]["acl_list"].arrayValue{
            let d = AddUserACLModel()
            d.objectMapping(json: data)
            user_acl_list.append(d)
        }
    }
}

class AddUserPositionModel: NSObject {
    var admin_pos_name = ""
    var admin_pos_id = ""
    
    func objectMapping(json : JSON){
        admin_pos_name = json["admin_pos_name"].stringValue
        admin_pos_id = json["admin_pos_id"].stringValue
    }
}

class AddUserACLModel: NSObject {
    var group_acl_id = ""
    var desc_acl = ""
    
    func objectMapping(json : JSON){
        group_acl_id = json["group_acl_id"].stringValue
        desc_acl = json["desc_acl"].stringValue
    }
}
