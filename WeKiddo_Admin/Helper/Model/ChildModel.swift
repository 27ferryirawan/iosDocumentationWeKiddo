//
//  ChildModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 30/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChildModel: NSObject {
    var student_type = 0
    var child_name = ""
    var school_id = ""
    var child_id: String?
    var school_grade_id = ""
    
    func objectMapping(json: JSON) {
        student_type = json["student_type"].intValue
        child_name = json["child_name"].stringValue
        school_id = json["school_id"].stringValue
        child_id = json["child_id"].stringValue
        school_grade_id = json["school_grade_id"].stringValue
    }
}
