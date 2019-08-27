//
//  PermissionDataModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 21/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class PermissionDataModel: NSObject {
    var permission_id = ""
    var child_name = ""
    var child_nis = ""
    var child_image = ""
    var school_class = ""
    var parent_name = ""
    var permission_request = ""
    var permission_desc = ""
    var created_date = ""
    var permission_date = ""
    var permission_to_date = ""
    var teacher_name = ""
    var class_leader = ""
    var count_sick = ""
    var count_leave = ""
    var count_alpha = ""
    var permission_reason = ""
    var permission_status = -1
    var medias = [PermissionMediaModel]()
    
    func objectMapping(json: JSON) {
        permission_id = json["data"]["permission_detail"]["permission_id"].stringValue
        child_name = json["data"]["permission_detail"]["child_name"].stringValue
        child_nis = json["data"]["permission_detail"]["child_nis"].stringValue
        permission_reason = json["data"]["permission_detail"]["permission_reason"].stringValue
        child_image = json["data"]["permission_detail"]["child_image"].stringValue
        school_class = json["data"]["permission_detail"]["school_class"].stringValue
        parent_name = json["data"]["permission_detail"]["parent_name"].stringValue
        permission_status = json["data"]["permission_detail"]["permission_status"].intValue
        permission_request = json["data"]["permission_detail"]["permission_request"].stringValue
        permission_desc = json["data"]["permission_detail"]["permission_desc"].stringValue
        created_date = json["data"]["permission_detail"]["created_at"].stringValue
        permission_date = json["data"]["permission_detail"]["permission_date"].stringValue
        permission_to_date = json["data"]["permission_detail"]["permission_to_date"].stringValue
        teacher_name = json["data"]["permission_detail"]["teacher_name"].stringValue
        class_leader = json["data"]["permission_detail"]["class_leader"].stringValue
        count_sick = json["data"]["permission_detail"]["count_sick"].stringValue
        count_leave = json["data"]["permission_detail"]["count_leave"].stringValue
        count_alpha = json["data"]["permission_detail"]["count_alpha"].stringValue
        for data in json["data"]["permission_detail"]["medias"].arrayValue {
            let d = PermissionMediaModel()
            d.objectMapping(json: data)
            medias.append(d)
        }
    }
}

class PermissionMediaModel: NSObject {
    var mediaId = ""
    var mediaURL = ""
    var media_type_id = ""
    
    func objectMapping(json: JSON) {
        mediaId = json["id"].stringValue
        mediaURL = json["url"].stringValue
        media_type_id = json["media_type_id"].stringValue
    }
}
