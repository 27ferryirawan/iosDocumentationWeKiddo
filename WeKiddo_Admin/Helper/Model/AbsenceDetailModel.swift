//
//  AbsenceDetailModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 30/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AbsenceDetailModel: NSObject {
    var child_id = ""
    var year_id = ""
    var child_name = ""
    var child_nis = ""
    var child_image = ""
    var school_class_id = ""
    var school_class = ""
    var status_absence = 0
    var reasons = [AbsenceDetailReasonModel]()
    
    func objectMapping(json: JSON) {
        child_id = json["data"]["info"]["absence_detail"]["child_id"].stringValue
        child_name = json["data"]["info"]["absence_detail"]["child_name"].stringValue
        child_nis = json["data"]["info"]["absence_detail"]["child_nis"].stringValue
        child_image = json["data"]["info"]["absence_detail"]["child_image"].stringValue
        school_class_id = json["data"]["info"]["absence_detail"]["school_class_id"].stringValue
        school_class = json["data"]["info"]["absence_detail"]["school_class"].stringValue
        status_absence = json["data"]["info"]["absence_detail"]["status_absence"].intValue
        year_id = json["data"]["info"]["absence_detail"]["year_id"].stringValue
        
        for data in json["data"]["info"]["reason_list"].arrayValue {
            let d = AbsenceDetailReasonModel()
            d.objectMapping(json: data)
            reasons.append(d)
        }
    }
}

class AbsenceDetailReasonModel: NSObject {
    var reason_id = ""
    var reason_desc = ""
    var reason_type = 0
    
    func objectMapping(json: JSON) {
        reason_id = json["reason_id"].stringValue
        reason_desc = json["reason_desc"].stringValue
        reason_type = json["reason_type"].intValue
    }
}
