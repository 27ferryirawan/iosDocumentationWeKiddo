//
//  SchoolModel.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 28/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class SchoolModel: NSObject {
    var school_id = ""
    var school_name = ""
    var school_address = ""
    var school_phone = ""
    var school_email = ""
    var school_media = ""
    var school_city = ""
    var school_desc = ""
    var school_ig = ""
    var school_youtube = ""
    var school_fb = ""
    var school_website = ""
    var school_latlong = ""
    var school_type = ""
    var school_logo = ""
    var school_grade = ""
    
    
    func objectMapping(json: JSON) {
        school_id = json["school_id"].stringValue
        school_name = json["school_name"].stringValue
        school_address = json["school_address"].stringValue
        school_phone = json["school_phone"].stringValue
        school_email = json["school_email"].stringValue
        school_media = json["school_media"].stringValue
        school_city = json["school_city"].stringValue
        school_desc = json["school_desc"].stringValue
        school_ig = json["school_ig"].stringValue
        school_youtube = json["school_youtube"].stringValue
        school_fb = json["school_fb"].stringValue
        school_website = json["school_website"].stringValue
        school_latlong = json["school_latlong"].stringValue
        school_type = json["stringValue"].stringValue
        school_logo = json["school_logo"].stringValue
        school_grade = json["school_grade"].stringValue
    }
}
