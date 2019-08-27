//
//  CurrentSessionModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 28/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SwiftyJSON

class CurrentSessionModel: NSObject {
    var session_late = 0
    var session_subjectName = ""
    var session_detention = 0
    var session_start = ""
    var session_end = ""
    
    func objectMapping(json: JSON) {
        session_late = json["information"]["session"]["late"].intValue
        session_subjectName = json["information"]["session"]["subjectName"].stringValue
        session_detention = json["information"]["session"]["detention"].intValue
        session_start = json["information"]["session"]["start"].stringValue
        session_end = json["information"]["session"]["end"].stringValue
    }
}
