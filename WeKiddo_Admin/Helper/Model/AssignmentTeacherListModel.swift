//
//  AssignmentTeacherListModel.swift
//  WeKiddo_Admin
//
//  Created by Yosua Hoo on 28/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

/*
User for
 /assignment/teacher-list
 /assignment/get-teacher
 */

class AssignmentTeacherContentModel : NSObject{
    var teacher_id = ""
    var teacher_name = ""
    
    func objectMapping(json: JSON) {
        teacher_id = json["teacher_id"].stringValue
        teacher_name = json["teacher_name"].stringValue
    }
}

class AssignmentTeacherListAllModel : NSObject{
    var assignmentTeacherList = [AssignmentTeacherContentModel]()
    
    func objectMapping(json: JSON) {
        for data in json["data"]["teacher_list_all"].arrayValue {
            let d = AssignmentTeacherContentModel()
            d.objectMapping(json: data)
            assignmentTeacherList.append(d)
        }
    }
}

class AssignmentTeacherListModel : NSObject {
    var assignmentTeacherList = [AssignmentTeacherContentModel]()
    
    func objectMapping(json: JSON) {
        for data in json["data"]["teacher_list"].arrayValue {
            let d = AssignmentTeacherContentModel()
            d.objectMapping(json: data)
            assignmentTeacherList.append(d)
        }
    }
}
