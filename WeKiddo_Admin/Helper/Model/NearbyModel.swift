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
    var school_name = ""
    var school_id = ""
    var school_logo = ""
    var school_list = [NearbySchoolListModel]()
    var course_list = [NearbyCourseListModel]()
    
    func objectMapping(json: JSON) {
        school_name = json["data"]["nearby_course"]["school_info"]["school_name"].stringValue
        school_id = json["data"]["nearby_course"]["school_info"]["school_id"].stringValue
        school_logo = json["data"]["nearby_course"]["school_info"]["school_logo"].stringValue
        for data in json["data"]["nearby_course"]["school_list"].arrayValue {
            let d = NearbySchoolListModel()
            d.objectMapping(json: data)
            school_list.append(d)
        }
        for data in json["data"]["nearby_course"]["list_course"].arrayValue {
            let d = NearbyCourseListModel()
            d.objectMapping(json: data)
            course_list.append(d)
        }
    }
}

class NearbySchoolListModel: NSObject {
    var year_id: String?
    var school_id: String?
    var school_name = ""
    
    func objectMapping(json: JSON) {
        year_id = json["year_id"].stringValue
        school_id = json["school_id"].stringValue
        school_name = json["school_name"].stringValue
    }
}

class NearbyCourseListModel: NSObject {
    var course_category = ""
    var course_category_id = 0
    var course_list_data = [NearbyCourseListDataModel]()
    
    func objectMapping(json: JSON) {
        course_category = json["course_category"].stringValue
        course_category_id = json["course_category_id"].intValue
        for data in json["data"].arrayValue {
            let d = NearbyCourseListDataModel()
            d.objectMapping(json: data)
            course_list_data.append(d)
        }
    }
}

class NearbyCourseListDataModel: NSObject {
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
    var course_category = ""
    var course_registration_link = ""
    var distance = ""
    var course_lat = ""
    var course_long = ""
    var kilometers = ""
    var header_id = 0
    var franchise_id = ""
    var course_name = ""
    var course_id = ""
    
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
        course_lat = json["course_lat"].stringValue
        course_long = json["course_long"].stringValue
        kilometers = json["kilometers"].stringValue
        header_id = json["header_id"].intValue
        course_category = json["course_category"].stringValue
        franchise_id = json["franchise_id"].stringValue
    }
}

