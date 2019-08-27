//
//  CompetitionCategoryModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 21/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class CompetitionCategoryModel: NSObject {
    var competition_category_id = ""
    var competition_category_title = ""
    var competition_category_image = ""
    
    func objectMapping(json: JSON) {
        competition_category_id = json["competition_category_id"].stringValue
        competition_category_title = json["competition_category_title"].stringValue
        competition_category_image = json["competition_category_image"].stringValue
    }
}
