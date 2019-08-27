//
//  FuturePlanCareerModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 23/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class FuturePlanCareerModel: NSObject {
    var career_id = ""
    var career_name = ""
    var career_image = ""
    
    func objectMapping(json: JSON) {
        career_id = json["career_id"].stringValue
        career_name = json["career_name"].stringValue
        career_image = json["career_image"].stringValue
    }
}
