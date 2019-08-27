//
//  LatePaymentListModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 17/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class LatePaymentListModel: NSObject {
    var child_id = ""
    var child_name = ""
    var school_class = ""
    var due_date = ""
    var payment_type = 0
    var child_payment_id = ""
    
    func objectMapping(json: JSON) {
        child_id = json["child_id"].stringValue
        child_name = json["child_name"].stringValue
        school_class = json["school_class"].stringValue
        due_date = json["due_date"].stringValue
        payment_type = json["payment_type"].intValue
        child_payment_id = json["child_payment_id"].stringValue
    }
}
