//
//  ClassroomModel.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 31/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class SOPDetailModel : NSObject{
    
    var sop_id = ""
    var sop_image = ""
    var sop_title = ""
    var sop_content = ""
    
    func objcMapping(json : JSON){
        sop_id = json["data"]["detail_sop"]["sop_id"].stringValue
        sop_image = json["data"]["detail_sop"]["sop_image"].stringValue
        sop_title = json["data"]["detail_sop"]["sop_title"].stringValue
        sop_content = json["data"]["detail_sop"]["sop_content"].stringValue
    }
}
