//
//  AnnouncementListModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 04/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AnnouncementListModel: NSObject {
    var school_announcement_id = ""
    var school_announcement_content = ""
    var start_date = ""
    
    func objectMapping(json: JSON) {
        school_announcement_id = json["school_announcement_id"].stringValue
        school_announcement_content = json["school_announcement_content"].stringValue
        start_date = json["start_date"].stringValue
    }
}
