//
//  StudentDetailMide.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 04/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class StudentDetailModel : NSObject{
    
    var child_id = ""
    var password = ""
    var child_name = ""
    var child_phone = ""
    var child_email = ""
    var child_address = ""
    var child_nis = ""
    var child_image = ""
    var child_bod = ""
    var child_gender = ""
    var child_religion = ""
    var role_id = 0
    var school_grade_id = ""
    var student_grade_role_id = 0
    var foster_status : Bool?
    var notification_competition = ""
    var is_premium : Bool?
    var family_master_id = ""
    var sequence_no = 0
    var changed_password : Bool?
    var school_id = ""
    var nisn = ""
    var parents = [ChildParentModel]()
    
    func objcMapping(json : JSON){
        child_id = json["data"]["detail_student"]["child_id"].stringValue
        password = json["data"]["detail_student"]["password"].stringValue
        child_name = json["data"]["detail_student"]["child_name"].stringValue
        child_phone = json["data"]["detail_student"]["child_phone"].stringValue
        child_email = json["data"]["detail_student"]["child_email"].stringValue
        child_address = json["data"]["detail_student"]["child_address"].stringValue
        child_nis = json["data"]["detail_student"]["child_nis"].stringValue
        child_image = json["data"]["detail_student"]["child_image"].stringValue
        child_bod = json["data"]["detail_student"]["child_bod"].stringValue
        child_gender = json["data"]["detail_student"]["child_gender"].stringValue
        child_religion = json["data"]["detail_student"]["child_religion"].stringValue
        role_id = json["data"]["detail_student"]["role_id"].intValue
        school_grade_id = json["data"]["detail_student"]["school_grade_id"].stringValue
        student_grade_role_id = json["data"]["detail_student"]["student_grade_role_id"].intValue
        foster_status = json["data"]["detail_student"]["foster_status"].boolValue
        notification_competition = json["data"]["detail_student"]["notification_competition"].stringValue
        is_premium = json["data"]["detail_student"]["is_premium"].boolValue
        family_master_id = json["data"]["detail_student"]["family_master_id"].stringValue
        sequence_no = json["data"]["detail_student"]["sequence_no"].intValue
        changed_password = json["data"]["detail_student"]["changed_password"].boolValue
        school_id = json["data"]["detail_student"]["school_id"].stringValue
        nisn = json["data"]["detail_student"]["nisn"].stringValue
        for data in json["data"]["detail_student"]["parents"].arrayValue{
            let d = ChildParentModel()
            d.objcMapping(json: data)
            parents.append(d)
        }
    }
}

class ChildParentModel : NSObject{
    var parent_id = ""
    var password = ""
    var parent_name = ""
    var parent_phone = ""
    var parent_email = ""
    var parent_address = ""
    var parent_occupation = ""
    var parent_company = ""
    var parent_position = ""
    var parent_image = ""
    var role_id = 0
    var changed_password : Bool?
    var gender = ""
    var parent_type = ""
    var parent_child_id = ""
    var child_id = ""
    var family_id = ""
    
    
    func objcMapping(json : JSON){
        parent_id = json["parent_id"].stringValue
        password = json["password"].stringValue
        parent_name = json["parent_name"].stringValue
        parent_phone = json["parent_phone"].stringValue
        parent_email = json["parent_email"].stringValue
        parent_address = json["parent_address"].stringValue
        parent_occupation = json["parent_occupation"].stringValue
        parent_company = json["parent_company"].stringValue
        parent_image = json["parent_image"].stringValue
        role_id = json["role_id"].intValue
        changed_password = json["changed_password"].boolValue
        gender = json["gender"].stringValue
        parent_type = json["parent_type"].stringValue
        parent_child_id = json["parent_child_id"].stringValue
        child_id = json["child_id"].stringValue
        family_id = json["family_id"].stringValue
    }
}
