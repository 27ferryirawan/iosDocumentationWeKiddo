//
//  StudentDetailMide.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 04/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class GetEditStudentDetailModel : NSObject{
    
    var school_name = ""
    var child_name = ""
    var child_nis = ""
    var child_image = ""
    var child_phone = ""
    var child_address = ""
    var child_email = ""
    var coming_date = ""
    var child_bod = ""
    var child_gender = ""
    var school_class = ""
    
    var edit_child_class = [EditChildClassList]()
    
    func objcMapping(json : JSON){
        
        school_name = json["data"]["student_data"]["student_detail"]["school_name"].stringValue
        child_name = json["data"]["student_data"]["student_detail"]["child_name"].stringValue
        child_nis = json["data"]["student_data"]["student_detail"]["child_nis"].stringValue
        child_image = json["data"]["student_data"]["student_detail"]["child_image"].stringValue
        child_phone = json["data"]["student_data"]["student_detail"]["child_phone"].stringValue
        child_address = json["data"]["student_data"]["student_detail"]["child_address"].stringValue
        child_email = json["data"]["student_data"]["student_detail"]["child_email"].stringValue
        coming_date = json["data"]["student_data"]["student_detail"]["coming_date"].stringValue
        child_bod = json["data"]["student_data"]["student_detail"]["child_bod"].stringValue
        child_gender = json["data"]["student_data"]["student_detail"]["child_gender"].stringValue
        school_class = json["data"]["student_data"]["student_detail"]["school_class"].stringValue
        for data in json["data"]["student_data"]["class_list"].arrayValue{
            let d = EditChildClassList()
            d.objcMapping(json: data)
            edit_child_class.append(d)
        }
    }
}

class EditChildClassList : NSObject{
   
    var school_class_id = ""
    var school_class = ""
    
    
    func objcMapping(json : JSON){
        school_class_id = json["school_class_id"].stringValue
        school_class = json["school_class"].stringValue
    }
}
