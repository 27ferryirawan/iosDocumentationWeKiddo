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
    
    var school_class = ""
    var school_class_id = ""
    
    func objcMapping(json : JSON){
        school_class = json["school_class"].stringValue
        school_class_id = json["school_class_id"].stringValue
    }
}
