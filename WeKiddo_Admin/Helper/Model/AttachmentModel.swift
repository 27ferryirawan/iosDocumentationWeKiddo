//
//  AttachmentModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 10/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AttachmentModel: NSObject {
    var media_type_id = ""
    var media_type_name = ""
    var attachments = [AttachmentListModel]()
    var voiceNotes = [VoiceNoteListModel]()
    var mediaTypes = [MediaTypeModel]()
    var mediasss = [AttachmentMediaModel]()

    func objectMapping(json: JSON) {
        media_type_id = json["media_type_id"].stringValue
        media_type_name = json["media_type_name"].stringValue
        for data in json["mediasss"].arrayValue {
            let d = AttachmentMediaModel()
            d.objectMapping(json: data)
            mediasss.append(d)
        }
        for data in json["data"]["attachment_list"]["attachment"].arrayValue {
            let d = AttachmentListModel()
            d.objectMapping(json: data)
            attachments.append(d)
        }
        for data in json["data"]["attachment_list"]["voice_note"].arrayValue {
            let d = VoiceNoteListModel()
            d.objectMapping(json: data)
            voiceNotes.append(d)
        }
        for data in json["data"]["attachment_list"]["media_type"].arrayValue {
            let d = MediaTypeModel()
            d.objectMapping(json: data)
            mediaTypes.append(d)
        }
    }
}

class AttachmentMediaModel: NSObject {
    var media_id = ""
    var url = ""
    var index = ""
    var mediable_type = ""
    var mediable_id = ""
    var media_type_id = ""
    
    func objectMapping(json: JSON) {
        media_id = json["media_id"].stringValue
        url = json["url"].stringValue
        index = json["index"].stringValue
        mediable_type = json["mediable_type"].stringValue
        mediable_id = json["mediable_id"].stringValue
        media_type_id = json["media_type_id"].stringValue
    }
}

class AttachmentListModel: NSObject {
    var media_id = 0
    var url = ""
    var index = ""
    var mediable_type = ""
    var mediable_id = ""
    var media_type_id = ""
    
    func objectMapping(json: JSON) {
        media_id = json["id"].intValue
        url = json["url"].stringValue
        index = json["index"].stringValue
        mediable_type = json["mediable_type"].stringValue
        mediable_id = json["mediable_id"].stringValue
        media_type_id = json["media_type_id"].stringValue
    }
}

class VoiceNoteListModel: NSObject {
    var media_id = 0
    var url = ""
    var index = ""
    var mediable_type = ""
    var mediable_id = ""
    var media_type_id = ""
    
    func objectMapping(json: JSON) {
        media_id = json["id"].intValue
        url = json["url"].stringValue
        index = json["index"].stringValue
        mediable_type = json["mediable_type"].stringValue
        mediable_id = json["mediable_id"].stringValue
        media_type_id = json["media_type_id"].stringValue
    }
}

class MediaTypeModel: NSObject {
    var media_id = ""
    var media_type_name = ""
    var media_type_id = ""
    
    func objectMapping(json: JSON) {
        media_id = json["media_id"].stringValue
        media_type_name = json["media_type_name"].stringValue
        media_type_id = json["media_type_id"].stringValue
    }
}
