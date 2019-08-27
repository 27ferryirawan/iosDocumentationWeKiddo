//
//  StudentNoteModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 10/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class StudentNoteModel: NSObject {
    var note_id = ""
    var child_id = ""
    var note_content = ""
    var attachment_id = ""
    
    func objectMapping(json: JSON) {
        note_id = json["notes"]["note_id"].stringValue
        child_id = json["notes"]["child_id"].stringValue
        note_content = json["notes"]["note_content"].stringValue
        attachment_id = json["notes"]["attachment_id"].stringValue
//        for data in json["perfomances"].arrayValue {
//            let d = SubjectListPerformanceModel()
//            d.objectMapping(json: data)
//            perfomances.append(d)
//        }
    }
}

//class SubjectListPerformanceModel: NSObject {
//    var month = ""
//    var score = ""
//    
//    func objectMapping(json: JSON) {
//        month = json["month"].stringValue
//        score = json["score"].stringValue
//    }
//}
