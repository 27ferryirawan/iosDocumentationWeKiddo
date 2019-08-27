//
//  ParentNewsModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 21/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ParentNewsModel: NSObject {
    var news_id = ""
    var news_title = ""
    var news_image = ""
    var news_url = ""
    
    func objectMapping(json: JSON) {
        news_id = json["news_id"].stringValue
        news_title = json["news_title"].stringValue
        news_image = json["news_image"].stringValue
        news_url = json["news_url"].stringValue
    }
}
