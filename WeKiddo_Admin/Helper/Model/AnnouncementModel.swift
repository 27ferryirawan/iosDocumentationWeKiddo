//
//  AnnouncementModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 19/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AnnouncementModel: NSObject {
    var school_announcement_id = ""
    var school_announcement_date = ""
    var school_announcement_subject = ""
    var need_approval = ""
    var school_announcement_media_id = ""
    var desc = ""
    var announcementMedia = [AnnouncementMediaModel]()
    
    func objectMapping(json: JSON) {
        school_announcement_id = json["school_announcement_id"].stringValue
        school_announcement_date = json["school_announcement_date"].stringValue
        school_announcement_subject = json["school_announcement_subject"].stringValue
//        need_approval = json["need_approval"].stringValue
        school_announcement_media_id = json["school_announcement_media_id"].stringValue
//        desc = json["school_announcement_desc"].stringValue
//        for data in json["media_types"].arrayValue {
//            let d = AnnouncementMediaModel()
//            d.objectMapping(json: data)
//            announcementMedia.append(d)
//        }
    }
}
