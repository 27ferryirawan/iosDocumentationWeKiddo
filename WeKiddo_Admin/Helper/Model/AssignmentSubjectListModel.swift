//
//  AssignmentSubjectListModel.swift
//  WeKiddo_Admin
//
//  Created by Yosua Hoo on 28/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

//Use for : /assignment/get-subject-class

class AssignmentSubjectListModel : NSObject {
    var subjectList = [AssignmentSubjectListContentModel]()
    var classList = [AssignmentSubjectListClassModel]()
    
    func objectMapping(json: JSON) {
        for data in json["data"]["subject_class_list"]["subject_list"].arrayValue {
            let d = AssignmentSubjectListContentModel()
            d.objectMapping(json: data)
            subjectList.append(d)
        }
        for data in json["data"]["subject_class_list"]["class_list"].arrayValue {
            let d = AssignmentSubjectListClassModel()
            d.objectMapping(json: data)
            classList.append(d)
        }
    }
}

class AssignmentSubjectListContentModel : NSObject {
    var subject_id = ""
    var subject_name = ""
    
    func objectMapping(json: JSON) {
        subject_id = json["subject_id"].stringValue
        subject_name = json["subject_name"].stringValue
    }
}

class AssignmentSubjectListClassModel : NSObject {
    var school_class_id = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        school_class = json["school_class"].stringValue
        school_class_id = json["school_class_id"].stringValue
    }
}
