//
//  NewsModel.swift
//  AYO CLEAN
//
//  Created by zein rezky chandra on 04/07/18.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsModel: NSObject {
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
