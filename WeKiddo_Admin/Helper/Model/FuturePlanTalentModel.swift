//
//  FuturePlanTalentModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 23/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class FuturePlanTalentModel: NSObject {
    var talent_id = ""
    var talent_name = ""
    var talent_image = ""
    
    func objectMapping(json: JSON) {
        talent_id = json["talent_id"].stringValue
        talent_name = json["talent_name"].stringValue
        talent_image = json["talent_image"].stringValue
    }
}
