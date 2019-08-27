//
//  SubjectTopicBySubjectModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 17/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class SubjectTopicBySubjectModel: NSObject {
    var subject_id = ""
    var subject_name = ""
    var class_shift = [SubjectTopicBySubjectClassShiftModel]()
    
    func objectMapping(json: JSON) {
        subject_id = json["subject_id"].stringValue
        subject_name = json["subject_name"].stringValue
        
        for data in json["class_shift"].arrayValue {
            let d = SubjectTopicBySubjectClassShiftModel()
            d.objectMapping(json: data)
            class_shift.append(d)
        }
    }
}

class SubjectTopicBySubjectClassShiftModel: NSObject {
    var school_level = ""
    var school_level_id = ""
    
    func objectMapping(json: JSON) {
        school_level = json["school_level"].stringValue
        school_level_id = json["school_level_id"].stringValue
    }
}

class SubjectTopicByClassModel: NSObject {
    var school_level = ""
    var school_level_id = ""
    var class_schedules = [SubjectTopicByClassClassShiftModel]()
    
    func objectMapping(json: JSON) {
        school_level = json["school_level"].stringValue
        school_level_id = json["school_level_id"].stringValue
        
        for data in json["class_schedules"].arrayValue {
            let d = SubjectTopicByClassClassShiftModel()
            d.objectMapping(json: data)
            class_schedules.append(d)
        }
    }
}

class SubjectTopicByClassClassShiftModel: NSObject {
    var school_class_id = ""
    var school_class = ""
    var subject_id = ""
    var subject_name = ""
    
    func objectMapping(json: JSON) {
        school_class_id = json["school_class_id"].stringValue
        school_class = json["school_class"].stringValue
        subject_id = json["has_subject"]["subject_id"].stringValue
        subject_name = json["has_subject"]["subject_name"].stringValue
    }
}
