//
//  PermissionModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 21/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class PermissionModel: NSObject {
    var permissionPending = [PermissionPendingModel]()
    var permissionApprove = [PermissionApproveModel]()
    var permissionReject = [PermissionRejectModel]()
    
    func objectMapping(json: JSON) {
        for data in json["data"]["pending"].arrayValue {
            let d = PermissionPendingModel()
            d.objectMapping(json: data)
            permissionPending.append(d)
        }
        for data in json["data"]["approve"].arrayValue {
            let d = PermissionApproveModel()
            d.objectMapping(json: data)
            permissionApprove.append(d)
        }
        for data in json["data"]["reject"].arrayValue {
            let d = PermissionRejectModel()
            d.objectMapping(json: data)
            permissionReject.append(d)
        }
    }
}

class PermissionPendingModel: NSObject {
    var permission_id = ""
    var permission_type = 0
    var permission_status = 0
    var permission_date = ""
    var child_name = ""
    var child_nis = ""
    var child_image = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        permission_id = json["permission_id"].stringValue
        permission_type = json["permission_type"].intValue
        permission_status = json["permission_status"].intValue
        permission_date = json["permission_date"].stringValue
        child_name = json["child_name"].stringValue
        child_nis = json["child_nis"].stringValue
        child_image = json["child_image"].stringValue
        school_class = json["school_class"].stringValue
    }
}

class PermissionApproveModel: NSObject {
    var permission_id = ""
    var permission_type = 0
    var permission_status = 0
    var permission_date = ""
    var child_name = ""
    var child_nis = ""
    var child_image = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        permission_id = json["permission_id"].stringValue
        permission_type = json["permission_type"].intValue
        permission_status = json["permission_status"].intValue
        permission_date = json["permission_date"].stringValue
        child_name = json["child_name"].stringValue
        child_nis = json["child_nis"].stringValue
        child_image = json["child_image"].stringValue
        school_class = json["school_class"].stringValue
    }
}

class PermissionRejectModel: NSObject {
    var permission_id = ""
    var permission_type = 0
    var permission_status = 0
    var permission_date = ""
    var child_name = ""
    var child_nis = ""
    var child_image = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        permission_id = json["permission_id"].stringValue
        permission_type = json["permission_type"].intValue
        permission_status = json["permission_status"].intValue
        permission_date = json["permission_date"].stringValue
        child_name = json["child_name"].stringValue
        child_nis = json["child_nis"].stringValue
        child_image = json["child_image"].stringValue
        school_class = json["school_class"].stringValue
    }
}
