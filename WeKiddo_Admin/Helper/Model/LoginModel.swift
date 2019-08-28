//
//  LoginModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 20/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoginModel: NSObject {
    var userID = ""
    var accessToken = ""
    var year_id = ""
    var expiredAt = ""
    var role = ""
    var school_id = ""
    var dashboardSchoolMenu = [DashboardSchoolMenu]()
    var dashboardMenu = [DashboardModelMenu]()
    var dashboardCategoryFeature = [DashboardCategoryFeature]()
    var dashboardCatgoryOthers = [DashboardCategoryOthers]()
    
    func objectMapping(json: JSON) {
        userID = json["data"]["user_id"].stringValue
        accessToken = json["data"]["access_token"].stringValue
        expiredAt = json["data"]["expired_at"].stringValue
        year_id = json["data"]["year_id"].stringValue
        role = json["data"]["role"].stringValue
        school_id = json["data"]["school_id"].stringValue
        
        for data in json["data"]["navbar"].arrayValue {
            let d = DashboardModelMenu()
            d.objectMapping(json: data)
            dashboardMenu.append(d)
        }
        for data in json["data"]["accesses"]["category_administration"].arrayValue {
            let d = DashboardCategoryFeature()
            d.objectMapping(json: data)
            dashboardCategoryFeature.append(d)
        }
        for data in json["data"]["accesses"]["category_others"].arrayValue {
            let d = DashboardCategoryOthers()
            d.objectMapping(json: data)
            dashboardCatgoryOthers.append(d)
        }
        for data in json["data"]["school_list"].arrayValue {
            let d = DashboardSchoolMenu()
            d.objectMapping(json: data)
            dashboardSchoolMenu.append(d)
        }
    }
}

class DashboardSchoolMenu: NSObject {
    var year_id: String?
    var school_id: String?
    var school_name: String?
    
    func objectMapping(json: JSON) {
        year_id = json["year_id"].stringValue
        school_id = json["school_id"].stringValue
        school_name = json["school_name"].stringValue
    }
}

class DashboardModelMenu: NSObject {
    var menu_name = ""
    var menu_id = ""
    
    func objectMapping(json: JSON) {
        menu_name = json["menu_name"].stringValue
        menu_id = json["menu_id"].stringValue
    }
}

class DashboardCategoryFeature: NSObject {
    var menu_name: String?
    var menu_id = ""
    var menu_category_id = ""
    
    func objectMapping(json: JSON) {
        menu_name = json["menu_name"].stringValue
        menu_id = json["menu_id"].stringValue
        menu_category_id = json["menu_category_id"].stringValue
    }
}

class DashboardCategoryOthers: NSObject {
    var menu_name: String?
    var menu_id = ""
    var menu_category_id = ""
    
    func objectMapping(json: JSON) {
        menu_name = json["menu_name"].stringValue
        menu_id = json["menu_id"].stringValue
        menu_category_id = json["menu_category_id"].stringValue
    }
}
