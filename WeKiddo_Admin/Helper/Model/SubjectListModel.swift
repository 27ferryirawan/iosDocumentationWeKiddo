//
//  SubjectListModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 09/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class SubjectListModel: NSObject {
    var subject_id = ""
    var subject_name = ""
    var subject_desc = ""
    var passing_grade = ""
    var radian = ""
    var color = ""
    var perfomances = [SubjectListPerformanceModel]()
    
    func objectMapping(json: JSON) {
        subject_id = json["subject_id"].stringValue
        subject_name = json["subject_name"].stringValue
        subject_desc = json["subject_desc"].stringValue
        passing_grade = json["passing_grade"].stringValue
        radian = json["radian"].stringValue
        color = json["color"].stringValue
        for data in json["perfomances"].arrayValue {
            let d = SubjectListPerformanceModel()
            d.objectMapping(json: data)
            perfomances.append(d)
        }
    }
}

class SubjectListPerformanceModel: NSObject {
    var month = ""
    var score = ""
    
    func objectMapping(json: JSON) {
        month = json["month"].stringValue
        score = json["score"].stringValue
    }
}
