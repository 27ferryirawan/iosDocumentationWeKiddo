//
//  AnnouncementDetail.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AnnouncementDetail: NSObject {
    var header_id = ""
    var announcement_title = ""
    var announcement_desc = ""
    var school_announcement_id = ""
    var start_date = ""
    var level = ""
    var childClass = ""
    var end_date = ""
    var field = [AnnouncementFieldModel]()
    var medias = [AnnouncementDetailMediasModel]()
    var childs = [AnnouncementDetailChildModel]()
    
    func objectMapping(json: JSON) {
        header_id = json["data"]["announcement_detail"]["header_id"].stringValue
        announcement_title = json["data"]["announcement_detail"]["announcement_title"].stringValue
        announcement_desc = json["data"]["announcement_detail"]["announcement_desc"].stringValue
        school_announcement_id = json["data"]["announcement_detail"]["school_announcement_id"].stringValue
        start_date = json["data"]["announcement_detail"]["start_date"].stringValue
        level = json["data"]["announcement_detail"]["level"].stringValue
        childClass = json["data"]["announcement_detail"]["class"].stringValue
        end_date = json["data"]["announcement_detail"]["end_date"].stringValue
        for data in json["data"]["announcement_detail"]["field"].arrayValue {
            let d = AnnouncementFieldModel()
            d.objectMapping(json: data)
            field.append(d)
        }
        for data in json["data"]["announcement_detail"]["medias"].arrayValue {
            let d = AnnouncementDetailMediasModel()
            d.objectMapping(json: data)
            medias.append(d)
        }
    }
}

class AnnouncementFieldModel: NSObject {
    var title_id = ""
    var header_id = ""
    var title_text = ""
    var desc = ""

    func objectMapping(json: JSON) {
        title_id = json["title_id"].stringValue
        header_id = json["header_id"].stringValue
        title_text = json["title_text"].stringValue
        desc = json["desc"].stringValue
    }
}

class AnnouncementDetailMediasModel: NSObject {
    var mediaID = ""
    var media_type_id = ""
    var url = ""
    
    func objectMapping(json: JSON) {
        mediaID = json["id"].stringValue
        media_type_id = json["media_type_id"].stringValue
        url = json["url"].stringValue
    }
}

class AnnouncementDetailChildModel: NSObject {
    var mediaID = ""
    var media_type_id = ""
    var url = ""
    
    func objectMapping(json: JSON) {
        mediaID = json["id"].stringValue
        media_type_id = json["media_type_id"].stringValue
        url = json["url"].stringValue
    }
}

class AnnouncementEditDetail: NSObject {
    var header_id = ""
    var announcement_title = ""
    var announcement_desc = ""
    var school_announcement_id = ""
    var start_date = ""
    var level = ""
    var childClass = ""
    var end_date = ""
    var field = [AnnouncementFieldModel]()
    var medias = [AnnouncementDetailMediasModel]()
    var childs = [AnnouncementDetailChildModel]()
    var levels = [AnnouncementLevelListModel]()
    
    func objectMapping(json: JSON) {
        header_id = json["data"]["announcement_edit"]["announcement_edit"]["header_id"].stringValue
        announcement_title = json["data"]["announcement_edit"]["announcement_edit"]["announcement_title"].stringValue
        announcement_desc = json["data"]["announcement_edit"]["announcement_edit"]["announcement_desc"].stringValue
        school_announcement_id = json["data"]["announcement_edit"]["announcement_edit"]["school_announcement_id"].stringValue
        start_date = json["data"]["announcement_edit"]["announcement_edit"]["start_date"].stringValue
        level = json["data"]["announcement_edit"]["announcement_edit"]["level"].stringValue
        childClass = json["data"]["announcement_edit"]["announcement_edit"]["class"].stringValue
        end_date = json["data"]["announcement_edit"]["announcement_edit"]["end_date"].stringValue
        for data in json["data"]["announcement_edit"]["announcement_edit"]["field"].arrayValue {
            let d = AnnouncementFieldModel()
            d.objectMapping(json: data)
            field.append(d)
        }
        for data in json["data"]["announcement_edit"]["announcement_edit"]["medias"].arrayValue {
            let d = AnnouncementDetailMediasModel()
            d.objectMapping(json: data)
            medias.append(d)
        }
        for data in json["data"]["announcement_edit"]["level"].arrayValue {
            let d = AnnouncementLevelListModel()
            d.objectMapping(json: data)
            levels.append(d)
        }
    }
}
