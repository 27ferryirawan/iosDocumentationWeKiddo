//
//  ScoreModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 07/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ScoreModel: NSObject {
    var subject_id = ""
    var subject_name = ""
    var subject_desc = ""
    var subject_color = ""
    var score = ""
    var score_type_id = ""
    var score_type = ""
    var score_description = ""
    var score_date = ""
    var date = ""
    var class_radiant = ""
    
    func objectMapping(json: JSON) {
        subject_id = json["subject_id"].stringValue
        subject_name = json["subject_name"].stringValue
        subject_desc = json["subject_desc"].stringValue
        subject_color = json["subject_color"].stringValue
        score = json["score"].stringValue
        score_type_id = json["score_type_id"].stringValue
        score_type = json["score_type"].stringValue
        score_description = json["score_description"].stringValue
        score_date = json["score_date"].stringValue
        date = json["date"].stringValue
        class_radiant = json["class_radiant"].stringValue
    }
}
