//
//  LatePaymentDetailModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 17/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class LatePaymentDetailModel: NSObject {
    var child_id = ""
    var school_id = ""
    var school_class = ""
    var year_id = ""
    var amount = ""
    var due_date = ""
    var payment_type = 0
    var desc = ""
    var payment_date = ""
    var payment_notes = ""
    var status = Bool()
    var child_payment_id = ""
    var child_name = ""
    
    func objectMapping(json: JSON) {
        child_id = json["data"]["child_payment"]["child_id"].stringValue
        school_id = json["data"]["child_payment"]["school_id"].stringValue
        year_id = json["data"]["child_payment"]["year_id"].stringValue
        amount = json["data"]["child_payment"]["amount"].stringValue
        due_date = json["data"]["child_payment"]["due_date"].stringValue
        payment_type = json["data"]["child_payment"]["payment_type"].intValue
        desc = json["data"]["child_payment"]["description"].stringValue
        payment_date = json["data"]["child_payment"]["payment_date"].stringValue
        payment_notes = json["data"]["child_payment"]["payment_notes"].stringValue
        status = json["data"]["child_payment"]["status"].boolValue
        child_payment_id = json["data"]["child_payment"]["child_payment_id"].stringValue
        child_name = json["data"]["child_payment"]["child_name"].stringValue
        school_class = json["data"]["child_payment"]["school_class"].stringValue
    }
}
