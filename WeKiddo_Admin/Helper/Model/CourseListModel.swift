//
//  CourseListModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 01/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class CourseListModel: NSObject {
    var course_session_id = ""
    var course_session_name = ""
    var course_day = ""
    var course_session_start = ""
    var course_session_end = ""
    var course_id = ""
    var course_category_id = ""
    var course_category = ""

    func objectMapping(json: JSON) {
        course_session_id = json["course_session_id"].stringValue
        course_session_name = json["course_session_name"].stringValue
        course_day = json["course_day"].stringValue
        course_session_start = json["course_session_start"].stringValue
        course_session_end = json["course_session_end"].stringValue
        course_id = json["course_id"].stringValue
        course_category_id = json["course_category_id"].stringValue
        course_category = json["course_category"].stringValue
    }
}
