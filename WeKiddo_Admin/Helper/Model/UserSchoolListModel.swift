//
//  UserSchoolListModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 06/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserSchoolListModel : NSObject {
    
    var school_id = ""
    var school_name = ""
    var year_id = ""
    
    func objectMapping(json : JSON){
        school_id = json["school_id"].stringValue
        school_name = json["school_name"].stringValue
        year_id = json["year_id"].stringValue
    }
}
