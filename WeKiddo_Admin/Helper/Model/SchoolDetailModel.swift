//
//  SchoolDetailModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 03/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class SchoolDetailModel: NSObject {
    var school_id = ""
    var school_name = ""
    var school_address = ""
    var school_phone = ""
    var school_email = ""
    var school_media = ""
    var school_city = ""
    var school_desc = ""
    var school_ig = ""
    var school_youtube = ""
    var school_fb = ""
    var school_website = ""
    var school_latlong = ""
    var school_type = ""
    var school_logo = ""
    var school_grade = ""
    var school_medias = [SchoolDetailMediaModel]()
    
    func objectMapping(json: JSON) {
        school_id = json["school detail"]["school_id"].stringValue
        school_name = json["school detail"]["school_name"].stringValue
        school_address = json["school detail"]["school_address"].stringValue
        school_phone = json["school detail"]["school_phone"].stringValue
        school_email = json["school detail"]["school_email"].stringValue
        school_media = json["school detail"]["school_media"].stringValue
        school_city = json["school detail"]["school_city"].stringValue
        school_desc = json["school detail"]["school_desc"].stringValue
        school_ig = json["school detail"]["school_ig"].stringValue
        school_youtube = json["school detail"]["school_youtube"].stringValue
        school_fb = json["school detail"]["school_fb"].stringValue
        school_website = json["school detail"]["school_website"].stringValue
        school_latlong = json["school detail"]["school_latlong"].stringValue
        school_type = json["school detail"]["stringValue"].stringValue
        school_logo = json["school detail"]["school_logo"].stringValue
        school_grade = json["school detail"]["school_grade"].stringValue
        for data in json["school detail"]["school_medias"].arrayValue {
            let d = SchoolDetailMediaModel()
            d.objectMapping(json: data)
            school_medias.append(d)
        }
    }
}

class SchoolDetailMediaModel: NSObject {
    var media_type_name = ""
    var media_url = ""
    var thumbnail = ""
    var youtube_id = ""
    
    func objectMapping(json: JSON) {
        media_type_name = json["media_type_name"].stringValue
        media_url = json["media_url"].stringValue
        thumbnail = json["thumbnail"].stringValue
        youtube_id = json["youtube_id"].stringValue
    }
}
