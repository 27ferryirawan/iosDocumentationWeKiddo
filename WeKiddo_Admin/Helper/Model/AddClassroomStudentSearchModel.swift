//
//  AddClassroomTeacherListModel.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 07/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AddClassroomStudentSearchModel : NSObject{
    
    var child_id: String?
    var child_name = ""
    var child_image = ""
    var child_nis = ""

    func objcMapping(json : JSON){
        child_id = json["child_id"].stringValue
        child_name = json["child_name"].stringValue
        child_image = json["child_image"].stringValue
        child_nis = json["child_nis"].stringValue
    }
}
