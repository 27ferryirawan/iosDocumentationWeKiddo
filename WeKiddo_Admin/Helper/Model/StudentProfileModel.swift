//
//  StudentProfileModel.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 09/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class StudentProfileModel: NSObject {
    
    var child_image = ""
    var child_name = ""
    var child_nis = ""
    var child_address = ""
    var child_phone = ""
    var child_email = ""
    var child_bod = ""
    var coming_year = ""
    var school_name = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        child_image = json["child_image"].stringValue
        child_name = json["child_name"].stringValue
        child_nis = json["child_nis"].stringValue
        child_address = json["child_address"].stringValue
        child_phone = json["child_phone"].stringValue
        child_email = json["child_email"].stringValue
        child_bod = json["child_bod"].stringValue
        coming_year = json["coming_year"].stringValue
        school_name = json["school_name"].stringValue
        school_class = json["school_class"].stringValue
    }
}

