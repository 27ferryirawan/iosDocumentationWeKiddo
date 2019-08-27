//
//  SpecialAttentionByClassListModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 05/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class SpecialAttentionByClassListModel: NSObject {
    var subject_id = ""
    var score_type_id = ""
    var score = ""
    var child_nis = ""
    var child_name = ""
    var school_class_id = ""
    var child_id = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        subject_id = json["subject_id"].stringValue
        score_type_id = json["score_type_id"].stringValue
        score = json["score"].stringValue
        child_nis = json["child_nis"].stringValue
        child_name = json["child_name"].stringValue
        school_class_id = json["school_class_id"].stringValue
        child_id = json["child_id"].stringValue
        school_class = json["school_class"].stringValue
    }
}
