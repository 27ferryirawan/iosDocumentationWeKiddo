//
//  StudentSearchModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 09/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class StudentSearchModel: NSObject {
    var child_id = ""
    var child_name = ""
    var child_image = ""
    var child_nis = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        child_id = json["child_id"].stringValue
        child_name = json["child_name"].stringValue
        child_image = json["child_image"].stringValue
        child_nis = json["child_nis"].stringValue
        school_class = json["school_class"].stringValue
    }
}

class StudentSearchSelected: Codable {
    var child_id = ""
    var child_name = ""
    var child_image = ""
    var child_nis = ""
    var school_class = ""
    
    init(childID: String, childName: String, childImage: String, childNIS: String, schoolClass: String) {
        self.child_id = childID
        self.child_name = childName
        self.child_image = childImage
        self.child_nis = childNIS
        self.school_class = schoolClass
    }
}

class StudentSetPaidModel: NSObject {
    var child_id = ""
    var date = ""
    
    init(childID: String, date:String) {
        self.child_id = childID
        self.date = date
    }
}
