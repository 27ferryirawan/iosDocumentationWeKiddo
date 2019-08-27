//
//  UserModel.swift
//  AYO CLEAN
//
//  Created by Zein Rezky Chandra on 27/05/18.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserModel: NSObject {
    var parent_phone = ""
    var parent_position = ""
    var parent_image = ""
    var parent_company = ""
    var parent_occupation = ""
    var role_id = ""
    var parent_email = ""
    var parent_name = ""
    var parent_address = ""
    var parent_id = ""
    var token = ""
    var role = ""
    var version = ""
    var status = ""
    
    func objectMapping(json: JSON) {
        parent_phone = json["login"]["parent_phone"].stringValue
        parent_position = json["login"]["parent_position"].stringValue
        parent_image = json["login"]["parent_image"].stringValue
        parent_company = json["login"]["parent_company"].stringValue
        parent_occupation = json["login"]["parent_occupation"].stringValue
        role_id = json["login"]["role_id"].stringValue
        parent_email = json["login"]["parent_email"].stringValue
        parent_name = json["login"]["parent_name"].stringValue
        parent_address = json["login"]["parent_address"].stringValue
        parent_id = json["login"]["parent_id"].stringValue
        token = json["token"].stringValue
        role = json["role"].stringValue
        version = json["version"].stringValue
        status = json["status"].stringValue
    }
}
