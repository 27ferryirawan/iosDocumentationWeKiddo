//
//  CareerDetailModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 23/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class CareerDetailModel: NSObject {
    var career_id = ""
    var career_name = ""
    var career_image = ""
    var career_description = ""
    var range_salary = ""
    var working_hours = ""
    var career_duties = ""
    var academic = [CareerAcademicModel]()
    var talent = [CareerTalentModel]()
    var universityMajor = [CareerUniversityMajorModel]()
    
    func objectMapping(json: JSON) {
        career_id = json["career"]["career_id"].stringValue
        career_name = json["career"]["career_name"].stringValue
        career_image = json["career"]["career_image"].stringValue
        career_description = json["career"]["career_description"].stringValue
        range_salary = json["career"]["range_salary"].stringValue
        working_hours = json["career"]["working_hours"].stringValue
        career_duties = json["career"]["career_duties"].stringValue
        for data in json["career"]["academic"].arrayValue {
            let d = CareerAcademicModel()
            d.objectMapping(json: data)
            academic.append(d)
        }
        for data in json["career"]["talent"].arrayValue {
            let d = CareerTalentModel()
            d.objectMapping(json: data)
            talent.append(d)
        }
        for data in json["career"]["university major"].arrayValue {
            let d = CareerUniversityMajorModel()
            d.objectMapping(json: data)
            universityMajor.append(d)
        }
    }
}

class CareerAcademicModel: NSObject {
    var academic_id = ""
    var academic_name = ""

    func objectMapping(json: JSON) {
        academic_id = json["academic_id"].stringValue
        academic_name = json["academic_name"].stringValue
    }
}

class CareerTalentModel: NSObject {
    var talent_id = ""
    var talent_name = ""

    func objectMapping(json: JSON) {
        talent_id = json["talent_id"].stringValue
        talent_name = json["talent_name"].stringValue
    }
}

class CareerUniversityMajorModel: NSObject {
    var major_id = ""
    var major_name = ""
    var major_image = ""

    func objectMapping(json: JSON) {
        major_id = json["major_id"].stringValue
        major_name = json["major_name"].stringValue
        major_image = json["major_image"].stringValue
    }
}
