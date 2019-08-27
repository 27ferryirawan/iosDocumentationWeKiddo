//
//  ChatModel.swift
//  AYO CLEAN
//
//  Created by zein rezky chandra on 07/08/18.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import EasyMapping

class ChatModelList: NSObject, EKMappingProtocol{
    @objc dynamic var promo = [ChatModel]()
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.hasMany(ChatModel.self, forKeyPath: "chats", forProperty: "promo")
        })
    }
}

class ChatModel: NSObject, EKMappingProtocol {
    
    @objc dynamic var chat_id = ""
    @objc dynamic var client_user_id = ""
    @objc dynamic var admin_user_id = ""
    @objc dynamic var chat_text = ""
    @objc dynamic var chat_date = ""
    @objc dynamic var chat_time = ""
    @objc dynamic var client_name = ""
    @objc dynamic var admin_name = ""
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.mapProperties(from:
                    [
                        "chat_id",
                        "client_name",
                        "client_user_id",
                        "admin_user_id",
                        "chat_text",
                        "admin_name",
                        "chat_date",
                        "chat_time"
                    ])
                /*
                let dateFormatter = DateFormatter()
                dateFormatter.locale = NSLocale.current
                dateFormatter.dateFormat = "yyyy-MM-dd"
                mapping.mapKeyPath("chat_date", toProperty: "chat_date", with: dateFormatter)
                 */
        })
    }
}
