//
//  StudentDetailMide.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 04/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class ClassroomMediaModel : NSObject{
    
    var url = ""
    var mediatype_id = ""
    var id = ""
    var media_type_id = ""
    var media_type_name = ""
    
    func objcMapping(json : JSON){
        url = json["data"]["media_file"]["url"].stringValue
        mediatype_id = json["data"]["media_file"]["media_type_id"].stringValue
        id = json["data"]["media_file"]["id"].stringValue
        media_type_id = json["data"]["media_file"]["type"]["media_type_id"].stringValue
        media_type_name = json["data"]["media_file"]["type"]["media_type_name"].stringValue
    }
}


