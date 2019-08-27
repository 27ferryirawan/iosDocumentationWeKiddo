//
//  ScoreSummaryModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 08/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ScoreSummaryModel: NSObject {
    var subject_id = ""
    var subject_name = ""
    var subject_desc = ""
    var passing_grade = ""
    var radian = ""
    var color = ""
    var perfomances = [ScoreSummaryPerformanceModel]()
    
    func objectMapping(json: JSON) {
        subject_id = json["subject_id"].stringValue
        subject_name = json["subject_name"].stringValue
        subject_desc = json["subject_desc"].stringValue
        passing_grade = json["passing_grade"].stringValue
        radian = json["radian"].stringValue
        color = json["color"].stringValue
        for data in json["perfomances"].arrayValue {
            let d = ScoreSummaryPerformanceModel()
            d.objectMapping(json: data)
            perfomances.append(d)
        }
    }
}

class ScoreSummaryPerformanceModel: NSObject {
    var month = ""
    var score = ""
    
    func objectMapping(json: JSON) {
        month = json["month"].stringValue
        score = json["score"].stringValue
    }
}
