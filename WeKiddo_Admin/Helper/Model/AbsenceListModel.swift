//
//  AbsenceListModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 30/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AbsenceListModel: NSObject {
    var school_class = ""
    var school_class_id = ""
    var absence_checkin = [AbsenceListCheckInModel]()
    var absence_checkout = [AbsenceListCheckOutModel]()
    
    func objectMapping(json: JSON) {
        school_class = json["school_class"].stringValue
        school_class_id = json["school_class_id"].stringValue
        
        for data in json["absence_checkin"].arrayValue {
            let d = AbsenceListCheckInModel()
            d.objectMapping(json: data)
            absence_checkin.append(d)
        }
        for data in json["absence_checkout"].arrayValue {
            let d = AbsenceListCheckOutModel()
            d.objectMapping(json: data)
            absence_checkout.append(d)
        }
    }
}

class AbsenceListCheckInModel: NSObject {
    var status_absence = 0
    var child_id = ""
    var child_name = ""
    var child_image = ""
    var child_nis = ""
    
    func objectMapping(json: JSON) {
        status_absence = json["status_absence"].intValue
        child_id = json["child_id"].stringValue
        child_name = json["child_name"].stringValue
        child_image = json["child_image"].stringValue
        child_nis = json["child_nis"].stringValue
    }
}

class AbsenceListCheckOutModel: NSObject {
    var status_absence = 0
    var child_id = ""
    var child_name = ""
    var child_image = ""
    var child_nis = ""
    var school_class = ""
    var school_class_id = ""
    
    func objectMapping(json: JSON) {
        status_absence = json["status_absence"].intValue
        child_id = json["child_id"].stringValue
        child_name = json["child_name"].stringValue
        child_image = json["child_image"].stringValue
        child_nis = json["child_nis"].stringValue
        school_class = json["school_class"].stringValue
        school_class_id = json["school_class_id"].stringValue
    }
}
