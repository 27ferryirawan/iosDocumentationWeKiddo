//
//  ClassroomModel.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 31/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class EditClassroomDetailModel : NSObject{
    
    var school_name = ""
    var school_level = ""
    var school_major_id = ""
    var school_class = ""
    var class_desc = ""
    
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
    
    
    func objcMapping(json : JSON){
        school_name = json["data"]["edit_class"]["detail"]["school_name"].stringValue
        school_level = json["data"]["edit_class"]["detail"]["school_level"].stringValue
        school_major_id = json["data"]["edit_class"]["detail"]["school_major_id"].stringValue
        school_class = json["data"]["edit_class"]["detail"]["school_class"].stringValue
        class_desc = json["data"]["edit_class"]["detail"]["class_desc"].stringValue
        
        teacher_id = json["data"]["edit_class"]["homeroom"]["teacher_id"].stringValue
        teacher_name = json["data"]["edit_class"]["homeroom"]["teacher_name"].stringValue
        teacher_image = json["data"]["edit_class"]["homeroom"]["teacher_image"].stringValue
        nuptk = json["data"]["edit_class"]["homeroom"]["nuptk"].stringValue
        
        leader_id = json["data"]["edit_class"]["class_leader"]["child_id"].stringValue
        leader_name = json["data"]["edit_class"]["class_leader"]["child_name"].stringValue
        leader_image = json["data"]["edit_class"]["class_leader"]["child_image"].stringValue
        leader_nis = json["data"]["edit_class"]["class_leader"]["child_nis"].stringValue
        
        secre_id = json["data"]["edit_class"]["secretary"]["child_id"].stringValue
        secre_name = json["data"]["edit_class"]["secretary"]["child_name"].stringValue
        secre_image = json["data"]["edit_class"]["secretary"]["child_image"].stringValue
        secre_nis = json["data"]["edit_class"]["secretary"]["child_nis"].stringValue
    }
}
