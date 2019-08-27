//
//  SessionsModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 19/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class SessionsModel: NSObject {
    var subject_name = ""
    var class_session_end = ""
    var class_session_start = ""
    var school_class_session_id = ""
    
    func objectMapping(json: JSON) {
        subject_name = json["subject_name"].stringValue
        class_session_end = json["class_session_end"].stringValue
        class_session_start = json["class_session_start"].stringValue
        school_class_session_id = json["school_class_session_id"].stringValue
    }
}
