//
//  ExamTypeModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 26/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ExamSubjectListModel: NSObject {
    var typeList = [ExamTypeContentModel]()
    var subjectList = [ExamSubjectContentModel]()
    
    func objectMapping(json: JSON) {
        for data in json["data"]["list"]["subject"].arrayValue {
            let d = ExamSubjectContentModel()
            d.objectMapping(json: data)
            subjectList.append(d)
        }
        for data in json["data"]["list"]["exam_type"].arrayValue {
            let d = ExamTypeContentModel()
            d.objectMapping(json: data)
            typeList.append(d)
        }
    }
}

class ExamLevelListModel: NSObject {
    var levelList = [ExamLevelContentModel]()
    var majorList = [ExamMajorContentModel]()
    
    func objectMapping(json: JSON){
        for data in json["data"]["list"]["level_list"].arrayValue {
            let d = ExamLevelContentModel()
            d.objectMapping(json: data)
            levelList.append(d)
        }
        for data in json["data"]["list"]["major_list"].arrayValue {
            let d = ExamMajorContentModel()
            d.objectMapping(json: data)
            majorList.append(d)
        }
    }
    
}

class ExamTypeContentModel: NSObject {
    var exam_type_id = ""
    var exam_type_name = ""
    
    func objectMapping(json: JSON) {
        exam_type_id = json["exam_type_id"].stringValue
        exam_type_name = json["exam_type_name"].stringValue
    }
}

class ExamMajorContentModel : NSObject{
    var school_major_id = ""
    var school_major = ""
    
    func objectMapping(json: JSON) {
        school_major_id = json["school_major_id"].stringValue
        school_major = json["school_major"].stringValue
    }
}

class ExamLevelContentModel: NSObject {
    var school_level = ""
    var school_level_id = ""
    
    func objectMapping(json: JSON) {
        school_level = json["school_level"].stringValue
        school_level_id = json["school_level_id"].stringValue
    }
}

class ExamSubjectContentModel: NSObject {
    var subject_name = ""
    var subject_id = ""
    
    func objectMapping(json: JSON) {
        subject_name = json["subject_name"].stringValue
        subject_id = json["subject_id"].stringValue
    }
}
