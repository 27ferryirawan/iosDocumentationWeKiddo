//
//  ParentProfileModel.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 09/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ParentProfileModel: NSObject {
    var teacher_dob = ""
    var teacher_phone = ""
    var teacher_id = ""
    var role_id = ""
    var teacher_email = ""
    var teacher_position = ""
    var nuptk = ""
    var teacher_image = ""
    var teacher_name = ""
    var school_id = ""
    var teacher_address = ""
    var gender = ""
    var subject_class = [ProfileSubjectClassModel]()
    var subject_list = [ProfileSubjectListModel]()
    var class_list = [ProfileSubjectClassListModel]()
    
    func objectMapping(json: JSON) {
        teacher_dob = json["data"]["teacher_profile"]["teacher_profile"]["teacher_dob"].stringValue
        teacher_phone = json["data"]["teacher_profile"]["teacher_profile"]["teacher_phone"].stringValue
        teacher_id = json["data"]["teacher_profile"]["teacher_profile"]["teacher_id"].stringValue
        role_id = json["data"]["teacher_profile"]["teacher_profile"]["role_id"].stringValue
        teacher_email = json["data"]["teacher_profile"]["teacher_profile"]["teacher_email"].stringValue
        teacher_position = json["data"]["teacher_profile"]["teacher_profile"]["teacher_position"].stringValue
        nuptk = json["data"]["teacher_profile"]["teacher_profile"]["nuptk"].stringValue
        teacher_image = json["data"]["teacher_profile"]["teacher_profile"]["teacher_image"].stringValue
        teacher_name = json["data"]["teacher_profile"]["teacher_profile"]["teacher_name"].stringValue
        school_id = json["data"]["teacher_profile"]["teacher_profile"]["school_id"].stringValue
        teacher_address = json["data"]["teacher_profile"]["teacher_profile"]["teacher_address"].stringValue
        gender = json["data"]["teacher_profile"]["teacher_profile"]["gender"].stringValue
        for data in json["data"]["teacher_profile"]["teacher_profile"]["subject_class"].arrayValue {
            let d = ProfileSubjectClassModel()
            d.objectMapping(json: data)
            subject_class.append(d)
        }
        for data in json["data"]["teacher_profile"]["subject_list"].arrayValue {
            let d = ProfileSubjectListModel()
            d.objectMapping(json: data)
            subject_list.append(d)
        }
        for data in json["data"]["teacher_profile"]["class_list"].arrayValue {
            let d = ProfileSubjectClassListModel()
            d.objectMapping(json: data)
            class_list.append(d)
        }
    }
}

class ProfileSubjectClassModel: NSObject {
    var school_class = ""
    var subject_name = ""
    var school_class_id = ""
    var school_subject_teacher_id = ""
    var subject_id = ""

    func objectMapping(json: JSON) {
        school_class = json["school_class"].stringValue
        subject_name = json["subject_name"].stringValue
        school_class_id = json["school_class_id"].stringValue
        school_subject_teacher_id = json["school_subject_teacher_id"].stringValue
        subject_id = json["subject_id"].stringValue
    }
}

class ProfileSubjectListModel: NSObject {
    var subject_name = ""
    var subject_id = ""
    
    func objectMapping(json: JSON) {
        subject_name = json["subject_name"].stringValue
        subject_id = json["subject_id"].stringValue
    }
}

class ProfileSubjectClassListModel: NSObject {
    var school_class_id = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        school_class_id = json["school_class_id"].stringValue
        school_class = json["school_class"].stringValue
    }
}
