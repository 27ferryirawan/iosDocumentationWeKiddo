//
//  CompetitionModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 21/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class CompetitionModel: NSObject {
    var competition_id = ""
    var competition_name = ""
    var competition_image = ""
    var competition_description = ""
    var competition_category_id = ""
    var competition_participant = ""
    var competition_phone = ""
    var competition_email = ""
    var competition_registration_link = ""
    var competition_city = ""
    var competition_latlong = ""
    var competition_start_date = ""
    var competition_end_date = ""
    var registration_date = ""
    
    func objectMapping(json: JSON) {
        competition_id = json["competition_id"].stringValue
        competition_name = json["competition_name"].stringValue
        competition_image = json["competition_image"].stringValue
        competition_description = json["competition_description"].stringValue
        competition_category_id = json["competition_category_id"].stringValue
        competition_participant = json["competition_participant"].stringValue
        competition_phone = json["competition_phone"].stringValue
        competition_email = json["competition_email"].stringValue
        competition_registration_link = json["competition_registration_link"].stringValue
        competition_city = json["competition_city"].stringValue
        competition_latlong = json["competition_latlong"].stringValue
        competition_start_date = json["competition_start_date"].stringValue
        competition_end_date = json["competition_end_date"].stringValue
        registration_date = json["registration_date"].stringValue
    }
}
