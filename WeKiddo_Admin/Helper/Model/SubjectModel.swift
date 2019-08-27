//
//  SubjectModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 06/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class SubjectModel: NSObject {
    var subject_id = ""
    var subject_name = ""
    
    func objectMapping(json: JSON) {
        subject_id = json["subject_id"].stringValue
        subject_name = json["subject_name"].stringValue
    }
}
