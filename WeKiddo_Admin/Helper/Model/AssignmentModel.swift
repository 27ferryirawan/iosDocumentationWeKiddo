//
//  AssignmentModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 19/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SwiftyJSON

class AssignmentModel {
    var assignment_id = ""
    var school_class = ""
    var subject_name = ""
    var chapter_name = ""
    var class_assign_date = ""
    var due_date = ""
    var teacher_id = ""

    func objectMapping(json: JSON) {
        assignment_id = json["assignment_id"].stringValue
        school_class = json["school_class"].stringValue
        subject_name = json["subject_name"].stringValue
        chapter_name = json["chapter_name"].stringValue
        class_assign_date = json["class_assign_date"].stringValue
        due_date = json["due_date"].stringValue
        teacher_id = json["teacher_id"].stringValue
    }
}
