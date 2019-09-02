//
//  AdminProfileModel.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 09/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AdminProfileModel: NSObject {
    var admin_id = ""
    var name = ""
    var phone = ""
    var gender = ""
    var email = ""
    var admin_dob = ""
    var admin_photo = ""
    var address = ""
    var admin_pos_id = ""
    var admin_pos_name = ""
    var group_acl_id = ""
    var assignSchool = [AdminAssignSchoolModel]()
    var posList = [AdminPosListModel]()
    
    func objectMapping(json: JSON) {
        admin_id = json["data"]["profile"]["admin_profile"]["admin_id"].stringValue
        name = json["data"]["profile"]["admin_profile"]["name"].stringValue
        phone = json["data"]["profile"]["admin_profile"]["phone"].stringValue
        gender = json["data"]["profile"]["admin_profile"]["gender"].stringValue
        email = json["data"]["profile"]["admin_profile"]["email"].stringValue
        admin_dob = json["data"]["profile"]["admin_profile"]["admin_dob"].stringValue
        admin_photo = json["data"]["profile"]["admin_profile"]["admin_photo"].stringValue
        address = json["data"]["profile"]["admin_profile"]["address"].stringValue
        admin_pos_id = json["data"]["profile"]["admin_profile"]["admin_pos_id"].stringValue
        admin_pos_name = json["data"]["profile"]["admin_profile"]["admin_pos_name"].stringValue
        group_acl_id = json["data"]["profile"]["admin_profile"]["group_acl_id"].stringValue
        for data in json["data"]["profile"]["assign_school"].arrayValue {
            let d = AdminAssignSchoolModel()
            d.objectMapping(json: data)
            assignSchool.append(d)
        }
        for data in json["data"]["profile"]["admin_pos_list"].arrayValue {
            let d = AdminPosListModel()
            d.objectMapping(json: data)
            posList.append(d)
        }
    }
}

class AdminAssignSchoolModel: NSObject {
    var school_name = ""
    var school_logo = ""
    
    func objectMapping(json: JSON) {
        school_name = json["school_name"].stringValue
        school_logo = json["school_logo"].stringValue
    }
}

class AdminPosListModel: NSObject {
    var admin_pos_id = ""
    var admin_pos_name = ""
    
    func objectMapping(json: JSON) {
        admin_pos_id = json["admin_pos_id"].stringValue
        admin_pos_name = json["admin_pos_name"].stringValue
    }
}
