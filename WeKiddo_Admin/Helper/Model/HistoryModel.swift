//
//  HistoryModel.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 31/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class HistoryModel : NSObject{
    

    var current_page = 0
    var first_page_url = ""
    var from = 0
    var next_page_url = ""
    var path = ""
    var per_page = 0
    var prev_page_url = ""
    var to = 0
    var dataObj = [HistoryListModel()]
    
    func objectMapping(json : JSON){
        current_page = json["data"]["history_list"]["current_page"].intValue
        first_page_url = json["data"]["history_list"]["first_page_url"].stringValue
        from = json["data"]["history_list"]["from"].intValue
        next_page_url = json["data"]["history_list"]["next_page_url"].stringValue
        path = json["data"]["history_list"]["path"].stringValue
        per_page = json["data"]["history_list"]["per_page"].intValue
        prev_page_url = json["data"]["history_list"]["prev_page_url"].stringValue
        to = json["data"]["history_list"]["to"].intValue
        for data in json["data"]["history_list"]["data"].arrayValue {
            let d = HistoryListModel()
            d.objectMapping(json: data)
            dataObj.append(d)
        }
    }
}

class HistoryListModel : NSObject{
    var userid = ""
    var user_type = ""
    var activity_log = ""
    var log_date = ""
    var name = ""
    var page_name = ""
    var app_name = ""
    
    func objectMapping(json : JSON){
        userid = json["userid"].stringValue
        user_type = json["user_type"].stringValue
        activity_log = json["activity_log"].stringValue
        log_date = json["log_date"].stringValue
        name = json["name"].stringValue
        page_name = json["page_name"].stringValue
        app_name = json["app_name"].stringValue
    }
}
