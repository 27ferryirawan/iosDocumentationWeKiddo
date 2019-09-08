//
//  ClassroomModel.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 31/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class SOPListModel : NSObject{
    
    var sop_id = ""
    var sop_image = ""
    var sop_title = ""
    
    func objcMapping(json : JSON){
        sop_id = json["sop_id"].stringValue
        sop_image = json["sop_image"].stringValue
        sop_title = json["sop_title"].stringValue
    }
}
