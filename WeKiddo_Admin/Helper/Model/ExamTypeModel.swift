//
//  ExamTypeModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 26/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ExamTypeModel: NSObject {
    var exam_type = [ExamTypeListModel]()
    var exam_subject = [ExamSubjectListModel]()
    var exam_level = [ExamLevelListModel]()
    
    func objectMapping(json: JSON) {
        for data in json["data"]["list"]["subject"].arrayValue {
            let d = ExamSubjectListModel()
            d.objectMapping(json: data)
            exam_subject.append(d)
        }
        for data in json["data"]["list"]["exam_type"].arrayValue {
            let d = ExamTypeListModel()
            d.objectMapping(json: data)
            exam_type.append(d)
        }
        for data in json["data"]["list"]["level"].arrayValue {
            let d = ExamLevelListModel()
            d.objectMapping(json: data)
            exam_level.append(d)
        }
    }
}

class ExamTypeListModel: NSObject {
    var exam_type_id = ""
    var exam_type_name = ""
    
    func objectMapping(json: JSON) {
        exam_type_id = json["exam_type_id"].stringValue
        exam_type_name = json["exam_type_name"].stringValue
    }
}

class ExamLevelListModel: NSObject {
    var school_level = ""
    var school_level_id = ""
    
    func objectMapping(json: JSON) {
        school_level = json["school_level"].stringValue
        school_level_id = json["school_level_id"].stringValue
    }
}

class ExamSubjectListModel: NSObject {
    var subject_name = ""
    var subject_id = ""
    
    func objectMapping(json: JSON) {
        subject_name = json["subject_name"].stringValue
        subject_id = json["subject_id"].stringValue
    }
}
