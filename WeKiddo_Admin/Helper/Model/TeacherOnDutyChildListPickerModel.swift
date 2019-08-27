//
//  TeacherOnDutyChildListPickerModel.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 20/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class TeacherOnDutyChildListPickerModel: NSObject {
    
    var class_picker = [TeacherOnDutyClassPickerModel]()
    var in_reason_picker = [TeacherOnDutyInReasonPickerModel]()
    var out_reason_picker = [TeacherOnDutyOutReasonPickerModel]()
    
    func objectMapping(json: JSON) {
        for classData in json["data"]["info"]["list_class"].arrayValue {
            let d = TeacherOnDutyClassPickerModel()
            d.objectMapping(json: classData)
            class_picker.append(d)
        }
        for inData in json["data"]["info"]["reason_in"].arrayValue {
            let d = TeacherOnDutyInReasonPickerModel()
            d.objectMapping(json: inData)
            in_reason_picker.append(d)
        }
        for outData in json["data"]["info"]["reason_out"].arrayValue {
            let d = TeacherOnDutyOutReasonPickerModel()
            d.objectMapping(json: outData)
            out_reason_picker.append(d)
        }
    }
}
class TeacherOnDutyClassPickerModel: NSObject {
    var school_class_id = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        school_class_id = json["school_class_id"].stringValue
        school_class = json["school_class"].stringValue
    }
}
class TeacherOnDutyInReasonPickerModel: NSObject {
    var reason_id = ""
    var reason_desc = ""
    var reason_type = ""
    
    func objectMapping(json: JSON) {
        reason_id = json["reason_id"].stringValue
        reason_desc = json["reason_desc"].stringValue
        reason_type = json["reason_type"].stringValue
    }
}
class TeacherOnDutyOutReasonPickerModel: NSObject {
    var reason_id = ""
    var reason_desc = ""
    var reason_type = ""
    
    func objectMapping(json: JSON) {
        reason_id = json["reason_id"].stringValue
        reason_desc = json["reason_desc"].stringValue
        reason_type = json["reason_type"].stringValue
    }
}



