//
//  FuturePlanAcademyModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 23/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class FuturePlanAcademyModel: NSObject {
    var academic_id = ""
    var academic_name = ""
    var academic_image = ""
    
    func objectMapping(json: JSON) {
        academic_id = json["academic_id"].stringValue
        academic_name = json["academic_name"].stringValue
        academic_image = json["academic_image"].stringValue
    }
}
