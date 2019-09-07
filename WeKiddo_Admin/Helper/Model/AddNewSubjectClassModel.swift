//
//  AddNewSubjectClassModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 07/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AddNewSubjectClassModel: NSObject {
    var school_subject_teacher_id = ""
    var subject_id = ""
    var subject_name = ""
    var school_class_id = ""
    var school_class = ""
    
    func objectMapping(json : JSON){
        school_subject_teacher_id = json["school_subject_teacher_id"].stringValue
        subject_id = json["subject_id"].stringValue
        subject_name = json["subject_name"].stringValue
        school_class_id = json["school_class_id"].stringValue
        school_class = json["school_class"].stringValue
    }
}

