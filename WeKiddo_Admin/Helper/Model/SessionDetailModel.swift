//
//  SessionDetailModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 06/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class SessionDetailModel: NSObject {
    var subject_session_id = ""
    var chapter_id = ""
    var subject_session = ""
    var subject_session_desc = ""
    var subject_id = ""
    var subject_name = ""
    var class_session_start = ""
    var class_session_end = ""
    var teacher_name = ""
    var image = ""
    
    func objectMapping(json: JSON) {
        subject_session_id = json["session_detail"]["subject_session_id"].stringValue
        chapter_id = json["session_detail"]["chapter_id"].stringValue
        subject_session = json["session_detail"]["subject_session"].stringValue
        subject_session_desc = json["session_detail"]["subject_session_desc"].stringValue
        subject_id = json["session_detail"]["subject_id"].stringValue
        subject_name = json["session_detail"]["subject_name"].stringValue
        class_session_start = json["session_detail"]["class_session_start"].stringValue
        class_session_end = json["session_detail"]["class_session_end"].stringValue
        teacher_name = json["session_detail"]["teacher_name"].stringValue
        image = json["session_detail"]["image"].stringValue
    }
}
