//
//  DetaliTicketModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 03/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class DetailTicketModel: NSObject {
    var response_time = ""
    var ticket_type = 0
    var ticket_id = ""
    var title = ""
    var created_at = ""
    var desc = ""
    var response_msg = ""
    var status = 0
    var chat = [DetailTicketChatModel]()
    var medias = [DetailTicketMediaModel]()
    
    func objectMapping(json:JSON){
        response_time = json["data"]["ticket"]["ticket_detail"]["response_time"].stringValue
        ticket_type = json["data"]["ticket"]["ticket_detail"]["ticket_type"].intValue
        ticket_id = json["data"]["ticket"]["ticket_detail"]["ticket_id"].stringValue
        title = json["data"]["ticket"]["ticket_detail"]["title"].stringValue
        created_at = json["data"]["ticket"]["ticket_detail"]["created_at"].stringValue
        desc = json["data"]["ticket"]["ticket_detail"]["description"].stringValue
        response_msg = json["data"]["ticket"]["ticket_detail"]["response_msg"].stringValue
        status = json["data"]["ticket"]["ticket_detail"]["status"].intValue
        
        for data in json["data"]["ticket"]["chat"].arrayValue{
            let d = DetailTicketChatModel()
            d.objectMapping(json: data)
            chat.append(d)
        }

        for data in json["data"]["ticket"]["medias"].arrayValue{
            let d = DetailTicketMediaModel()
            d.objectMapping(json: data)
            medias.append(d)
        }

    }
}

class DetailTicketChatModel: NSObject {
    var chat_msg = ""
    var sender_id = ""
    var ticket_id = ""
    
    func objectMapping(json:JSON){
        chat_msg = json["chat_msg"].stringValue
        sender_id = json["sender_id"].stringValue
        ticket_id = json["ticket_id"].stringValue
    }
}

class DetailTicketMediaModel: NSObject {
    var url = ""
    var media_type_id = ""
    var mediable_id = ""
    var mediable_type = ""
    var media_id = 0
    
    func objectMapping(json:JSON){
        url = json["url"].stringValue
        media_type_id = json["media_type_id"].stringValue
        mediable_id = json["mediable_id"].stringValue
        mediable_type = json["mediable_type"].stringValue
        media_id = json["media_id"].intValue
    }
}


class TicketMediaModel: NSObject {
    var media_id = 0
    var media_url = ""
    
    init(mediaID: Int, mediaURL: String) {
        self.media_id = mediaID
        self.media_url = mediaURL
    }
}
