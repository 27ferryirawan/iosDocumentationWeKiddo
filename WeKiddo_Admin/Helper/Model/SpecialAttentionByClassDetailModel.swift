//
//  SpecialAttentionByClassDetailModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 05/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class SpecialAttentionByClassDetailModel: NSObject {
    var child_id = ""
    var child_nis = ""
    var child_image = ""
    var child_name = ""
    var subject_count = 0
    var score_list = [SpecialAttentionByClassDetailScoreListModel]()
    
    func objectMapping(json: JSON) {
        child_id = json["data"]["special_attention"]["child_id"].stringValue
        child_nis = json["data"]["special_attention"]["child_nis"].stringValue
        child_image = json["data"]["special_attention"]["child_image"].stringValue
        child_name = json["data"]["special_attention"]["child_name"].stringValue
        subject_count = json["data"]["special_attention"]["subject_count"].intValue
        for data in json["data"]["special_attention"]["score_list"].arrayValue {
            let d = SpecialAttentionByClassDetailScoreListModel()
            d.objectMapping(json: data)
            score_list.append(d)
        }
    }
}

class SpecialAttentionByClassDetailScoreListModel: NSObject {
    var subject_id = ""
    var subject_name = ""
    var passing_grade = 0
    var radiant = 0
    var score = ""
    
    func objectMapping(json: JSON) {
        subject_id = json["subject_id"].stringValue
        subject_name = json["subject_name"].stringValue
        passing_grade = json["passing_grade"].intValue
        radiant = json["radiant"].intValue
        score = json["score"].stringValue
    }
}
