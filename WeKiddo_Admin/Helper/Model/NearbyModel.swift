//
//  NearbyModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 21/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class NearbyModel: NSObject {
    var course_category_id = 0
    var course_category = ""
    var courses = [NearbyCourseModel]()
    
    func objectMapping(json: JSON) {
        course_category_id = json["course_category_id"].intValue
        course_category = json["course_category"].stringValue
        for data in json["courses"].arrayValue {
            let d = NearbyCourseModel()
            d.objectMapping(json: data)
            courses.append(d)
        }
    }
}

class NearbyCourseModel: NSObject {
    var course_id = ""
    var course_name = ""
    var course_desc = ""
    var course_phone = ""
    var course_email = ""
    var course_address = ""
    var course_location = 0.0
    var course_image = ""
    var course_facebook = ""
    var course_linkedin = ""
    var course_instagram = ""
    var course_category_id = 0
    var course_registration_link = ""
    var distance = ""
    var course_lat = 0.0
    var course_long = 0.0
    
    func objectMapping(json: JSON) {
        course_id = json["course_id"].stringValue
        course_name = json["course_name"].stringValue
        course_desc = json["course_desc"].stringValue
        course_phone = json["course_phone"].stringValue
        course_email = json["course_email"].stringValue
        course_address = json["course_address"].stringValue
        course_location = json["course_location"].doubleValue
        course_image = json["course_image"].stringValue
        course_facebook = json["course_facebook"].stringValue
        course_linkedin = json["course_linkedin"].stringValue
        course_instagram = json["course_instagram"].stringValue
        course_registration_link = json["course_registration_link"].stringValue
        course_category_id = json["course_category_id"].intValue
        distance = json["distance"].stringValue
        course_lat = json["course_lat"].doubleValue
        course_long = json["course_long"].doubleValue
    }
}
