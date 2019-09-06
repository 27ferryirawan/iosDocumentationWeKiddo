//
//  ClassroomModel.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 31/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ClassroomModel : NSObject{
    
    var school_name = ""
    var school_level = ""
    var school_major_id = ""
    var school_class = ""
    var school_id = ""
    var class_desc = ""
    var year_desc = ""
    
    var teacher_id = ""
    var teacher_name = ""
    var teacher_image = ""
    var nuptk = ""
    
    var leader_id = ""
    var leader_name = ""
    var leader_image = ""
    var leader_nis = ""
    
    var secre_id = ""
    var secre_name = ""
    var secre_image = ""
    var secre_nis = ""
    
    var list_student = [ClassroomListStudentModel]()
    
    func objcMapping(json : JSON){
        school_class = json["data"]["class_detail"]["detail"]["school_class"].stringValue
        school_level = json["data"]["class_detail"]["detail"]["school_level"].stringValue
        school_major_id = json["data"]["class_detail"]["detail"]["school_major_id"].stringValue
        school_class = json["data"]["class_detail"]["detail"]["school_class"].stringValue
        school_id = json["data"]["class_detail"]["detail"]["school_id"].stringValue
        class_desc = json["data"]["class_detail"]["detail"]["class_desc"].stringValue
        year_desc = json["data"]["class_detail"]["detail"]["year_desc"].stringValue
        
        teacher_id = json["data"]["class_detail"]["homeroom"]["teacher_id"].stringValue
        teacher_name = json["data"]["class_detail"]["homeroom"]["teacher_name"].stringValue
        teacher_image = json["data"]["class_detail"]["homeroom"]["teacher_image"].stringValue
        nuptk = json["data"]["class_detail"]["homeroom"]["nuptk"].stringValue
        
        leader_id = json["data"]["class_detail"]["class_leader"]["child_id"].stringValue
        leader_name = json["data"]["class_detail"]["class_leader"]["child_name"].stringValue
        leader_image = json["data"]["class_detail"]["class_leader"]["child_image"].stringValue
        leader_nis = json["data"]["class_detail"]["class_leader"]["child_nis"].stringValue
        
        secre_id = json["data"]["class_detail"]["secretary"]["child_id"].stringValue
        secre_name = json["data"]["class_detail"]["secretary"]["child_name"].stringValue
        secre_image = json["data"]["class_detail"]["secretary"]["child_image"].stringValue
        secre_nis = json["data"]["class_detail"]["secretary"]["child_nis"].stringValue
        
        for data in json["data"]["class_detail"]["list_student"].arrayValue{
            let d = ClassroomListStudentModel()
            d.objcMapping(json: data)
            list_student.append(d)
        }
    }
}

class ClassroomListStudentModel : NSObject{
    var child_id = ""
    var child_name = ""
    var child_image = ""
    var child_nis = ""
    var school_id = ""
    var year_id = ""
    
    func objcMapping(json : JSON){
        child_id = json["child_id"].stringValue
        child_name = json["child_name"].stringValue
        child_image = json["child_image"].stringValue
        child_nis = json["child_nis"].stringValue
        school_id = json["school_id"].stringValue
        year_id = json["year_id"].stringValue
    }
}
