//
//  AddClassroomTeacherListModel.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 07/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AddClassroomTeacherListModel : NSObject{
    
    var teacher_id: String?
    var teacher_name = ""
    var teacher_phone = ""
    var teacher_image = ""
    var nuptk = ""
    var school_class_id = ""
    var school_class = ""
    
    func objcMapping(json : JSON){
        teacher_id = json["teacher_id"].stringValue
        teacher_name = json["teacher_name"].stringValue
        teacher_phone = json["teacher_phone"].stringValue
        teacher_image = json["teacher_image"].stringValue
        nuptk = json["nuptk"].stringValue
        school_class_id = json["school_class_id"].stringValue
        school_class = json["school_class"].stringValue
    }
}
