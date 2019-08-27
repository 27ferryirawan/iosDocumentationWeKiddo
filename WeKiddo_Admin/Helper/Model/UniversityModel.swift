//
//  UniversityModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 23/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class UniversityModel: NSObject {
    var university_id = ""
    var university_name = ""
    var university_image = ""
    
    func objectMapping(json: JSON) {
        university_id = json["university_id"].stringValue
        university_name = json["university_name"].stringValue
        university_image = json["university_image"].stringValue
    }
}
