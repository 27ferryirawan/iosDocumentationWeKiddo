//
//  DashboardModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 24/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class DashboardModel: NSObject {
    var home_profile_school_name = ""
    var home_profile_school_logo = ""
    var home_profile_school_grade = ""
    var home_profile_school_id = ""
    var home_profile_admin_name = ""
    var home_absent_count = 0
    var home_tasklist_count = 0
    var home_session_count = 0
    
    var dashboardTaskList = [DashboardModelTaskList]()
    var dashboardAbsentCheckList = [DashboardModelAbsentCheckList]()
    var dashboardSessionCheckList = [DashboardModelSessionCheckList]()

    func objectMapping(json: JSON) {
        home_profile_school_name = json["data"]["school_info"]["school_name"].stringValue
        home_profile_school_logo = json["data"]["school_info"]["school_logo"].stringValue
        home_profile_school_id = json["data"]["school_info"]["school_id"].stringValue
        home_profile_school_grade = json["data"]["school_info"]["school_grade"].stringValue
        home_profile_admin_name = json["data"]["school_info"]["user_name"].stringValue

        home_absent_count = json["data"]["count"]["absence"].intValue
        home_tasklist_count = json["data"]["count"]["tasklist"].intValue
        home_session_count = json["data"]["count"]["session"].intValue

        for data in json["data"]["session_checklist"].arrayValue {
            let d = DashboardModelSessionCheckList()
            d.objectMapping(json: data)
            dashboardSessionCheckList.append(d)
        }
        for data in json["data"]["absent_checklist"].arrayValue {
            let d = DashboardModelAbsentCheckList()
            d.objectMapping(json: data)
            dashboardAbsentCheckList.append(d)
        }
        for data in json["data"]["task_list"].arrayValue {
            let d = DashboardModelTaskList()
            d.objectMapping(json: data)
            dashboardTaskList.append(d)
        }
    }
}

class DashboardModelTaskList: NSObject {
    var assign_task_id = 0
    var title = ""
    var desc = ""
    var status = 0
    var task_date = ""
    var task_id = ""
    
    func objectMapping(json: JSON) {
        assign_task_id = json["assign_task_id"].intValue
        title = json["title"].stringValue
        desc = json["description"].stringValue
        status = json["status"].intValue
        task_date = json["task_date"].stringValue
        task_id = json["task_id"].stringValue
    }
}

class DashboardModelAbsentCheckList: NSObject {
    var school_class_id = ""
    var child_image = ""
    var status_absence = 0
    var school_class = ""
    var child_id = ""
    var child_nis = ""
    var child_name = ""
    
    func objectMapping(json: JSON) {
        school_class_id = json["school_class_id"].stringValue
        child_image = json["child_image"].stringValue
        status_absence = json["status_absence"].intValue
        school_class = json["school_class"].stringValue
        child_id = json["child_id"].stringValue
        child_nis = json["child_nis"].stringValue
        child_name = json["child_name"].stringValue
    }
}

class DashboardModelSessionCheckList: NSObject {
    var school_class_id = ""
    var child_image = ""
    var status_absence = 0
    var school_class = ""
    var child_id = ""
    var child_nis = ""
    var child_name = ""
    
    func objectMapping(json: JSON) {
        school_class_id = json["school_class_id"].stringValue
        child_image = json["child_image"].stringValue
        status_absence = json["status_absence"].intValue
        school_class = json["school_class"].stringValue
        child_id = json["child_id"].stringValue
        child_nis = json["child_nis"].stringValue
        child_name = json["child_name"].stringValue
    }
}
