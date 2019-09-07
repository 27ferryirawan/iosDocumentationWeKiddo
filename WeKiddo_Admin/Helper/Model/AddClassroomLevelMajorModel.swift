//
//  StudentDetailMide.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 04/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class AddClassroomLevelMajorModel : NSObject{
    
    var level = [ClassroomLevelModel]()
    var major = [ClassroomMajorModel]()
    
    func objcMapping(json : JSON){
        for data in json["data"]["list_level_major"]["level"].arrayValue{
            let d = ClassroomLevelModel()
            d.objcMapping(json: data)
            level.append(d)
        }
        for data in json["data"]["list_level_major"]["major"].arrayValue{
            let d = ClassroomMajorModel()
            d.objcMapping(json: data)
            major.append(d)
        }
    }
}

class ClassroomLevelModel : NSObject{
    
    var school_level = ""
    var school_level_id: String?
    
    func objcMapping(json : JSON){
        school_level = json["school_level"].stringValue
        school_level_id = json["school_level_id"].stringValue
    }
}
class ClassroomMajorModel : NSObject{
    
    var school_major_id: String?
    var school_major = ""
    
    func objcMapping(json : JSON){
        school_major_id = json["school_major_id"].stringValue
        school_major = json["school_major"].stringValue
    }
}
