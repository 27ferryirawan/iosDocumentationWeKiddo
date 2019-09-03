//
//  ClassroomModel.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 31/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ClassroomDashModel : NSObject{
    
    var school_id = ""
    var school_name = ""
    var school_logo = ""
    var school_grade = ""
    var classroom_class_list = [ClassListModel]()
    
    func objcMapping(json : JSON){
        school_id = json["data"]["list_classroom"]["class_detail"]["school_id"].stringValue
        school_name = json["data"]["list_classroom"]["class_detail"]["school_name"].stringValue
        school_logo = json["data"]["list_classroom"]["class_detail"]["school_logo"].stringValue
        school_grade = json["data"]["list_classroom"]["class_detail"]["school_grade"].stringValue
        for data in json["data"]["list_classroom"]["class_list"].arrayValue{
            let d = ClassListModel()
            d.objcMapping(json: data)
            classroom_class_list.append(d)
        }
    }
}

class ClassListModel : NSObject{
    var school_level_id = ""
    var school_level = ""
    var school_major_id = ""
    var classroom_classes = [ClassroomClassesModel]()
    
    func objcMapping(json : JSON){
        school_level_id = json["school_level_id"].stringValue
        school_level = json["school_level"].stringValue
        school_major_id = json["school_major_id"].stringValue
        for data in json["classes"].arrayValue{
            let d = ClassroomClassesModel()
            d.objcMapping(json: data)
            classroom_classes.append(d)
        }
    }
}

class ClassroomClassesModel : NSObject{
    var school_class_id = ""
    var school_class = ""
    var teacher_id = ""
    var teacher_name = ""
    var countStudent = 0
    
    func objcMapping(json : JSON){
        school_class_id = json["school_class_id"].stringValue
        school_class = json["school_class"].stringValue
        teacher_id = json["teacher_id"].stringValue
        teacher_name = json["teacher_name"].stringValue
        countStudent = json["count"].intValue
    }
}
