//
//  CourseDetailModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 25/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class CourseDetailModel: NSObject {
    var course_id = ""
    var course_name = ""
    var course_desc = ""
    var course_phone = ""
    var course_email = ""
    var course_address = ""
    var course_location = ""
    var course_image = ""
    var course_facebook = ""
    var course_linkedin = ""
    var course_instagram = ""
    var course_category_id = ""
    var course_registration_link = ""
    var distance = ""
    var course_lat = ""
    var course_long = ""
    var course_list = [CourseDetailListModel]()

    func objectMapping(json: JSON) {
        course_id = json["course"]["course_id"].stringValue
        course_name = json["course"]["course_name"].stringValue
        course_desc = json["course"]["course_desc"].stringValue
        course_phone = json["course"]["course_phone"].stringValue
        course_email = json["course"]["course_email"].stringValue
        course_address = json["course"]["course_address"].stringValue
        course_location = json["course"]["course_location"].stringValue
        course_image = json["course"]["course_image"].stringValue
        course_facebook = json["course"]["course_facebook"].stringValue
        course_linkedin = json["course"]["course_linkedin"].stringValue
        course_instagram = json["course"]["course_instagram"].stringValue
        course_category_id = json["course"]["course_category_id"].stringValue
        course_registration_link = json["course"]["course_registration_link"].stringValue
        distance = json["course"]["distance"].stringValue
        course_lat = json["course"]["course_lat"].stringValue
        course_long = json["course"]["course_long"].stringValue
        for data in json["course"]["course_list"].arrayValue {
            let d = CourseDetailListModel()
            d.objectMapping(json: data)
            course_list.append(d)
        }
    }
}

class CourseDetailListModel: NSObject {
    var course_list_id = ""
    var course_id = ""
    var course_list_name = ""
    var course_list_desc = ""

    func objectMapping(json: JSON) {
        course_list_id = json["course_list_id"].stringValue
        course_id = json["course_id"].stringValue
        course_list_name = json["course_list_name"].stringValue
        course_list_desc = json["course_list_desc"].stringValue
    }
}
