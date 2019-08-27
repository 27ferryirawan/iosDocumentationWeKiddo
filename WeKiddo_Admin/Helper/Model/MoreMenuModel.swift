//
//  MoreMenuModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 28/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SwiftyJSON

class MoreMenuModel: NSObject {
    var menu_name = ""
    var menu_id = 0
    
    func objectMapping(json: JSON) {
        menu_name = json["menu_name"].stringValue
        menu_id = json["menu_id"].intValue
    }
}
