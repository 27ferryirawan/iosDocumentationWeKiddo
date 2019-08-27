//
//  AssignmentModulModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AssignmentModulModel {
    var school_assignment_id = ""
    var assignment_due_date = ""
    var subject_session = ""
    var subject_name = ""
    var assignment_status = ""
    
     func objectMapping(json: JSON) {
         school_assignment_id = json["school_assignment_id"].stringValue
         assignment_due_date = json["assignment_due_date"].stringValue
         subject_session = json["subject_session"]["subject_session"].stringValue
         subject_name = json["subject_session"]["subject"]["subject_name"].stringValue
         assignment_status = json["assignment_status"].stringValue
     }
}
