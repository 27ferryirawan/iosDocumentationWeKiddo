//
//  AgencyModel.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 18/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AgencyModel: NSObject {
    var agency_id = ""
    var agency_name = ""
    var agency_image = ""
    var agency_address = ""
    var agency_phone_number = ""
    var agency_email = ""
    
    
    func objectMapping(json: JSON) {
        agency_id = json["agency_id"].stringValue
        agency_name = json["agency_name"].stringValue
        agency_image = json["agency_image"].stringValue
        agency_address = json["agency_address"].stringValue
        agency_phone_number = json["agency_phone_number"].stringValue
        agency_email = json["agency_email"].stringValue
    }
}
