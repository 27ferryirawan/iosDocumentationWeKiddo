//
//  AnnouncementLevelListModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 10/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AnnouncementLevelListModel: NSObject {
    var school_level_id = ""
    var school_level = ""
    
    func objectMapping(json: JSON) {
        school_level_id = json["school_level_id"].stringValue
        school_level = json["school_level"].stringValue
    }
}
