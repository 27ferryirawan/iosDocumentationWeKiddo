//
//  DetentionModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 09/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class DetentionModel: NSObject {
    var detention_date = ""
    var dateForHuman = ""
    var detention_items = [DetentionItemsModel]()
    
    func objectMapping(json: JSON) {
        detention_date = json["detention_date"].stringValue
        dateForHuman = json["dateForHuman"].stringValue
        for data in json["detention_items"].arrayValue {
            let d = DetentionItemsModel()
            d.objectMapping(json: data)
            detention_items.append(d)
        }
    }
}

class DetentionItemsModel: NSObject {
    var teacher_name = ""
    var child_image = ""
    var detention_date = ""
    var student_detention_id = ""
    var reason = ""
    var child_name = ""
    var child_nis = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        school_class = json["school_class"].stringValue
        teacher_name = json["teacher_name"].stringValue
        child_image = json["child_image"].stringValue
        detention_date = json["detention_date"].stringValue
        student_detention_id = json["student_detention_id"].stringValue
        reason = json["reason"].stringValue
        child_name = json["child_name"].stringValue
        child_nis = json["child_nis"].stringValue
    }
}
