//
//  ExamsModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 05/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ExamsModel: NSObject {
    var school_exam_subject = ""
    var start_time = ""
    var school_exam_date = ""
    var school_exam_desc = ""
    var school_class_id = ""
    var subject_name = ""
    var school_exam_id = ""
    var end_time = ""
    
    func objectMapping(json: JSON) {
        school_exam_subject = json["school_exam_subject"].stringValue
        start_time = json["start_time"].stringValue
        school_exam_date = json["school_exam_date"].stringValue
        school_exam_desc = json["school_exam_desc"].stringValue
        school_class_id = json["school_class_id"].stringValue
        subject_name = json["subject_name"].stringValue
        school_exam_id = json["school_exam_id"].stringValue
        end_time = json["end_time"].stringValue
    }
}
