//
//  AssignmentAttachmentListModel.swift
//  WeKiddo_Admin
//
//  Created by Yosua Hoo on 28/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AssignmentAttachmentListModel : NSObject {
    var attachmentList = [AssignmentAttachmentContentModel]()
    var voiceNoteList = [AssignmentAttachmentVoiceNoteModel]()
    var mediaTypeList = [AssignmentAttachmentMediaTypeModel]()
    
    func objectMapping(json: JSON){
        for data in json["data"]["attachment_list"]["attachment"].arrayValue{
            let d = AssignmentAttachmentContentModel()
            d.objectMapping(json: data)
            attachmentList.append(d)
        }
        for data in json["data"]["attachment_list"]["voice_note"].arrayValue{
            let d = AssignmentAttachmentVoiceNoteModel()
            d.objectMapping(json: data)
            voiceNoteList.append(d)
        }
        for data in json["data"]["attachment_list"]["media_type"].arrayValue{
            let d = AssignmentAttachmentMediaTypeModel()
            d.objectMapping(json: data)
            mediaTypeList.append(d)
        }
    }
}

class AssignmentAttachmentContentModel : NSObject {
    var id = ""
    var url = ""
    
    func objectMapping(json: JSON){
        id = json ["id"].stringValue
        url = json ["url"].stringValue
    }
}

class AssignmentAttachmentVoiceNoteModel : NSObject {
    var id = ""
    var url = ""
    
    func objectMapping(json: JSON){
        id = json ["id"].stringValue
        url = json ["url"].stringValue
    }
}

class AssignmentAttachmentMediaTypeModel : NSObject {
    var media_type_id = ""
    var media_type_name = ""
    
    func objectMapping(json: JSON){
        media_type_id = json ["media_type_id"].stringValue
        media_type_name = json ["media_type_name"].stringValue
    }
}
