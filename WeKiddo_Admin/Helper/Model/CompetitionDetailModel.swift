//
//  CompetitionDetailModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 24/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class CompetitionDetailModel: NSObject {
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
    var created_at = ""
    var updated_at = ""
    var competition_start_date = ""
    var competition_end_date = ""
    var registration_date = ""
    var competition_category_title = ""
    var competition_category_image = ""

    func objectMapping(json: JSON) {
        competition_id = json["competition"]["competition_id"].stringValue
        competition_name = json["competition"]["competition_name"].stringValue
        competition_image = json["competition"]["competition_image"].stringValue
        competition_description = json["competition"]["competition_description"].stringValue
        competition_category_id = json["competition"]["competition_category_id"].stringValue
        competition_participant = json["competition"]["competition_participant"].stringValue
        competition_phone = json["competition"]["competition_phone"].stringValue
        competition_email = json["competition"]["competition_email"].stringValue
        competition_registration_link = json["competition"]["competition_registration_link"].stringValue
        competition_city = json["competition"]["competition_city"].stringValue
        competition_latlong = json["competition"]["competition_latlong"].stringValue
        created_at = json["competition"]["created_at"].stringValue
        updated_at = json["competition"]["updated_at"].stringValue
        competition_start_date = json["competition"]["competition_start_date"].stringValue
        competition_end_date = json["competition"]["competition_end_date"].stringValue
        registration_date = json["competition"]["registration_date"].stringValue
        competition_category_title = json["competition"]["competition_category_title"].stringValue
        competition_category_image = json["competition"]["competition_category_image"].stringValue
    }
}
