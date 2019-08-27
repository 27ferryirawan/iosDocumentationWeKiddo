//
//  AnnouncementMediaModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AnnouncementMediaModel: NSObject {
    var media_url = ""
    var media_type_name = ""
    
    func objectMapping(json: JSON) {
        media_url = json["media_url"].stringValue
        media_type_name = json["media_type_name"].stringValue
    }
}
