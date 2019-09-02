//
//  ExamTeacherList.swift
//  WeKiddo_Admin
//
//  Created by Yosua Hoo on 31/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ExamTeacherListAll : NSObject{
    var teacherList = [ExamTeacherContent]()
    
    func objectMapping(json: JSON){
        for data in json["data"]["teacher_list_all"].arrayValue{
            let d = ExamTeacherContent()
            d.objectMapping(json: data)
            teacherList.append(d)
        }
    }
}

class ExamTeacherList : NSObject{
    var teacherList = [ExamTeacherContent]()
    
    func objectMapping(json: JSON){
        for data in json["data"]["teacher_list"].arrayValue{
            let d = ExamTeacherContent()
            d.objectMapping(json: data)
            teacherList.append(d)
        }
    }
}

class ExamTeacherContent : NSObject {
    var teacher_id = ""
    var teacher_name = ""
    
    func objectMapping(json: JSON){
        self.teacher_id = json["teacher_id"].stringValue
        self.teacher_name = json["teacher_name"].stringValue
    }
}
