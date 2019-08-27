//
//  ApprovalDetailModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 08/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ApprovalDetailModel: NSObject {
    var event_id = ""
    var event_name = ""
    var address = ""
    var event_media = ""
    var start_event_date = ""
    var end_event_date = ""
    var event_due_date = ""
    var amount = ""
    var desc = ""
    var event_latlong = ""
    var school_level_id = ""
    var school_class_id = ""
    var is_approved = ""
    var is_charge = Bool()
    var header_id = ""
    var count_approve = 0
    var count_reject = 0
    var count_paid = 0
    var count_pending = 0
    var count_total = 0
    var medias = [ApprovalDetailMediaModel]()
    var field = [ApprovalDetailFieldModel]()
    var list_class = [ApprovalDetailListClassModel]()
    
    func objectMapping(json: JSON) {
        event_id = json["data"]["event_detail"]["event_id"].stringValue
        address = json["data"]["event_detail"]["address"].stringValue
        event_name = json["data"]["event_detail"]["event_name"].stringValue
        event_media = json["data"]["event_detail"]["event_media"].stringValue
        start_event_date = json["data"]["event_detail"]["start_event_date"].stringValue
        end_event_date = json["data"]["event_detail"]["end_event_date"].stringValue
        event_due_date = json["data"]["event_detail"]["event_due_date"].stringValue
        amount = json["data"]["event_detail"]["amount"].stringValue
        desc = json["data"]["event_detail"]["desc"].stringValue
        event_latlong = json["data"]["event_detail"]["event_latlong"].stringValue
        school_level_id = json["data"]["event_detail"]["school_level_id"].stringValue
        school_class_id = json["data"]["event_detail"]["school_class_id"].stringValue
        is_approved = json["data"]["event_detail"]["is_approved"].stringValue
        header_id = json["data"]["event_detail"]["header_id"].stringValue
        is_charge = json["data"]["event_detail"]["is_charge"].boolValue
        count_approve = json["data"]["event_detail"]["information"]["count_approve"].intValue
        count_reject = json["data"]["event_detail"]["information"]["count_reject"].intValue
        count_paid = json["data"]["event_detail"]["information"]["count_paid"].intValue
        count_pending = json["data"]["event_detail"]["information"]["count_pending"].intValue
        count_total = json["data"]["event_detail"]["information"]["count_total"].intValue
        
        for data in json["data"]["event_detail"]["medias"].arrayValue {
            let d = ApprovalDetailMediaModel()
            d.objectMapping(json: data)
            medias.append(d)
        }
        for data in json["data"]["event_detail"]["field"].arrayValue {
            let d = ApprovalDetailFieldModel()
            d.objectMapping(json: data)
            field.append(d)
        }
        for data in json["data"]["event_detail"]["list_class"].arrayValue {
            let d = ApprovalDetailListClassModel()
            d.objectMapping(json: data)
            list_class.append(d)
        }
    }
}

class ApprovalDetailMediaModel: NSObject {
    var url = ""
    var media_type_id = ""
    var media_id = ""
    
    func objectMapping(json: JSON) {
        url = json["url"].stringValue
        media_type_id = json["media_type_id"].stringValue
        media_id = json["id"].stringValue
    }
}

class ApprovalDetailFieldModel: NSObject {
    var title_id = ""
    var header_id = ""
    var title_text = ""
    var desc = ""
    
    func objectMapping(json: JSON) {
        title_id = json["title_id"].stringValue
        header_id = json["header_id"].stringValue
        title_text = json["title_text"].stringValue
        desc = json["desc"].stringValue
    }
}

class ApprovalDetailListClassModel: NSObject {
    var school_class_id = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        school_class_id = json["school_class_id"].stringValue
        school_class = json["school_class"].stringValue
    }
}

class EventCountModel: NSObject {
    var count_paid = 0
    var count_total = 0
    var teacher_name = ""
    var count_reject = 0
    var count_pending = 0
    var count_approve = 0
    var school_class = ""
    
    func objectMapping(json: JSON) {
        count_paid = json["data"]["information"]["count_paid"].intValue
        count_total = json["data"]["information"]["count_total"].intValue
        teacher_name = json["data"]["information"]["teacher_name"].stringValue
        count_reject = json["data"]["information"]["count_reject"].intValue
        count_pending = json["data"]["information"]["count_pending"].intValue
        count_approve = json["data"]["information"]["count_approve"].intValue
        school_class = json["data"]["information"]["school_class"].stringValue
    }
}
