//
//  AboutUsModel.swift
//  AYO CLEAN
//
//  Created by Zein Rezky Chandra on 29/05/18.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import EasyMapping

class AboutUsModel: NSObject, EKMappingProtocol {
    @objc dynamic var title = ""
    @objc dynamic var content = ""
    @objc dynamic var updated_at = ""
    
    convenience init(email:String) {
        self.init()
        //        self.email = email
    }
    
    static func objectMapping() -> EKObjectMapping {
        return EKObjectMapping(
            for: self,
            with: {(mapping) in
                mapping.mapKeyPath("title", toProperty: "title")
                mapping.mapKeyPath("content", toProperty: "content")
                mapping.mapKeyPath("updated_at", toProperty: "updated_at")
        })
    }
}
