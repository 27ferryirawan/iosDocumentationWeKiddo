//
//  CourseBrandModel.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 26/10/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class CourseBrandModel : NSObject{
    
    var subjectName = ""
    var subjectList = [CourseBrandSubjectModel]()
    
    func objectMapping(json : JSON){
        subjectName = json["subjectName"].stringValue
        for data in json["list"].arrayValue{
            let d = CourseBrandSubjectModel()
            d.objectMapping(json: data)
            subjectList.append(d)
        }
    }
}

class CourseBrandSubjectModel: NSObject {
    var desc = ""
    var franchise_name = ""
    var subject_name = ""
    var franchise_id = 0
    var franchise_image = ""
    var header_id = ""
    
    func objectMapping(json : JSON){
        desc = json["desc"].stringValue
        franchise_name = json["franchise_name"].stringValue
        subject_name = json["subject_name"].stringValue
        franchise_id = json["franchise_id"].intValue
        franchise_image = json["franchise_image"].stringValue
        header_id = json["header_id"].stringValue
    }
}
