//
//  MenuCategoryOthersModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 08/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SwiftyJSON

class MenuCategoryOthersModel: NSObject {
    var menu_name: String?
    var menu_id = ""
    var menu_category_id = ""
    
    func objectMapping(json: JSON) {
        menu_name = json["menu_name"].stringValue
        menu_id = json["menu_id"].stringValue
        menu_category_id = json["menu_category_id"].stringValue
    }
}
