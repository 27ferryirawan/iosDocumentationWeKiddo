//
//  MedicalModel.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 18/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class MedicalModel: NSObject {
    var medical_record_id = ""
    var medical_date = ""
    var symptom = ""
    var medical_action = ""
    var medicine = ""
    var hospital = ""
    var doctor = ""
    var diagnose_attachment = ""
    var recipe_attachment = ""
    
    func objectMapping(json: JSON) {
        medical_record_id = json["medical_record_id"].stringValue
        medical_date = json["medical_date"].stringValue
        symptom = json["symptom"].stringValue
        medical_action = json["medical_action"].stringValue
        medicine = json["medicine"].stringValue
        hospital = json["hospital"].stringValue
        doctor = json["doctor"].stringValue
        diagnose_attachment = json["diagnose_attachment"].stringValue
        recipe_attachment = json["recipe_attachment"].stringValue
    }
}
