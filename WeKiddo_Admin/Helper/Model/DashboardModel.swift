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
    var home_profile_school_classname = ""
    var home_profile_teacher_name = ""
    var home_profile_teacher_role = ""
    
    var upcoming_session_school_session_id = ""
    var upcoming_session_school_session_date = ""
    var upcoming_session_school_start_time = ""
    var upcoming_session_school_end_time = ""
    var upcoming_session_school_is_join_class = ""
    var upcoming_session_school_subject_id = ""
    var upcoming_session_school_subject_name = ""
    var upcoming_session_school_school_class_id = ""
    var upcoming_session_school_school_class = ""
    var upcoming_session_school_chapter_id = ""
    var upcoming_session_school_chapter_name = ""
    var upcoming_session_school_chapter_desc = ""
    
    var current_class_session_school_session_id = ""
    var current_class_session_school_class_id = ""
    var current_class_session_is_join_class = ""
    var current_class_session_start_time = ""
    var current_class_session_end_time = ""
    var current_class_session_subject_name = ""
    var current_class_session_chapter_name = ""
    var current_class_session_chapter_desc = ""
    
    var dashboardAssignment = [DashboardModelAssignment]()
    var dashboardSpecialAttentionSubject = [DashboardModelSpecialAttentionSubject]()
    var dashboardSpecialAttentionClass = [DashboardModelSpecialAttentionClass]()
    var dashboardNews = [DashboardModelNews]()
    var dashboardPermissionRequest = [DashboardModelPermissionRequest]()
    var dashboardDetention = [DashboardModelDetention]()
    var dashboarCurrentClassSession = [DashboarModelCurrentClassSession]()
    var dashboardEventMonitoring = [DashboardModelEventMonitoring]()
    var dashboardEventLatePayment = [DashboardModelLatePayment]()

    func objectMapping(json: JSON) {
        home_profile_school_name = json["data"]["home_profile"]["school_name"].stringValue
        home_profile_school_logo = json["data"]["home_profile"]["school_logo"].stringValue
        home_profile_school_classname = json["data"]["home_profile"]["school_classname"].stringValue
        home_profile_teacher_name = json["data"]["home_profile"]["teacher_name"].stringValue
        home_profile_teacher_role = json["data"]["home_profile"]["teacher_role"].stringValue

        upcoming_session_school_session_id = json["data"]["upcoming_session"]["school_session_id"].stringValue
        upcoming_session_school_session_date = json["data"]["upcoming_session"]["session_date"].stringValue
        upcoming_session_school_start_time = json["data"]["upcoming_session"]["start_time"].stringValue
        upcoming_session_school_end_time = json["data"]["upcoming_session"]["end_time"].stringValue
        upcoming_session_school_is_join_class = json["data"]["upcoming_session"]["is_join_class"].stringValue
        upcoming_session_school_subject_id = json["data"]["upcoming_session"]["subject_id"].stringValue
        upcoming_session_school_subject_name = json["data"]["upcoming_session"]["subject_name"].stringValue
        upcoming_session_school_school_class_id = json["data"]["upcoming_session"]["school_class_id"].stringValue
        upcoming_session_school_school_class = json["data"]["upcoming_session"]["school_class"].stringValue
        upcoming_session_school_chapter_id = json["data"]["upcoming_session"]["chapter_id"].stringValue
        upcoming_session_school_chapter_name = json["data"]["upcoming_session"]["chapter_name"].stringValue
        upcoming_session_school_chapter_id = json["data"]["upcoming_session"]["chapter_desc"].stringValue
        
        current_class_session_school_session_id = json["data"]["current_class_session"]["school_session_id"].stringValue
        current_class_session_school_class_id = json["data"]["current_class_session"]["school_class_id"].stringValue
        current_class_session_is_join_class = json["data"]["current_class_session"]["is_join_class"].stringValue
        current_class_session_start_time = json["data"]["current_class_session"]["start_time"].stringValue
        current_class_session_end_time = json["data"]["current_class_session"]["end_time"].stringValue
        current_class_session_subject_name = json["data"]["current_class_session"]["subject_name"].stringValue
        current_class_session_chapter_name = json["data"]["current_class_session"]["chapter_name"].stringValue
        current_class_session_chapter_desc = json["data"]["current_class_session"]["chapter_desc"].stringValue

        for data in json["data"]["assignments"].arrayValue {
            let d = DashboardModelAssignment()
            d.objectMapping(json: data)
            dashboardAssignment.append(d)
        }
        for data in json["data"]["permission_request"].arrayValue {
            let d = DashboardModelPermissionRequest()
            d.objectMapping(json: data)
            dashboardPermissionRequest.append(d)
        }
        for data in json["data"]["current_class_session"]["students"].arrayValue {
            let d = DashboarModelCurrentClassSession()
            d.objectMapping(json: data)
            dashboarCurrentClassSession.append(d)
        }
        for data in json["data"]["special_attention_subject"].arrayValue {
            let d = DashboardModelSpecialAttentionSubject()
            d.objectMapping(json: data)
            dashboardSpecialAttentionSubject.append(d)
        }
        for data in json["data"]["special_attention_class"].arrayValue {
            let d = DashboardModelSpecialAttentionClass()
            d.objectMapping(json: data)
            dashboardSpecialAttentionClass.append(d)
        }
        for data in json["data"]["detention"].arrayValue {
            let d = DashboardModelDetention()
            d.objectMapping(json: data)
            dashboardDetention.append(d)
        }
        for data in json["data"]["news"].arrayValue {
            let d = DashboardModelNews()
            d.objectMapping(json: data)
            dashboardNews.append(d)
        }
        for data in json["data"]["event_monitoring"].arrayValue {
            let d = DashboardModelEventMonitoring()
            d.objectMapping(json: data)
            dashboardEventMonitoring.append(d)
        }
        for data in json["data"]["late_payment"].arrayValue {
            let d = DashboardModelLatePayment()
            d.objectMapping(json: data)
            dashboardEventLatePayment.append(d)
        }
    }
}

class DashboardModelPermissionRequest: NSObject {
    var child_image = ""
    var permission_type = ""
    var child_name = ""
    var child_nis = ""
    var permission_date = ""
    var permission_id = ""
    
    func objectMapping(json: JSON) {
        child_image = json["child_image"].stringValue
        permission_type = json["permission_type"].stringValue
        child_name = json["child_name"].stringValue
        child_nis = json["child_nis"].stringValue
        permission_date = json["permission_date"].stringValue
        permission_id = json["permission_id"].stringValue
    }
}

class DashboarModelCurrentClassSession: NSObject {
    var child_name = ""
    var child_image = ""
    var child_id = ""
    var child_nis = ""
    var is_attend = ""
    
    func objectMapping(json: JSON) {
        child_name = json["child_name"].stringValue
        child_image = json["child_image"].stringValue
        child_id = json["child_id"].stringValue
        child_nis = json["child_nis"].stringValue
        is_attend = json["is_attend"].stringValue
    }
}

class DashboardModelAssignment: NSObject {
    var assignment_id = ""
    var assignment_due_date = ""
    var assignment_status = ""
    var school_class_id = ""
    var subject_name = ""
    var subject_session = ""

    func objectMapping(json: JSON) {
        assignment_id = json["assignment_id"].stringValue
        assignment_due_date = json["assignment_due_date"].stringValue
        assignment_status = json["assignment_status"].stringValue
        school_class_id = json["school_class_id"].stringValue
        subject_name = json["subject_name"].stringValue
        subject_session = json["subject_session"].stringValue
    }
}

class DashboardModelDetention: NSObject {
    var teacher_name = ""
    var reason = ""
    var child_image = ""
    var student_detention_id = ""
    var child_name = ""
    var child_nis = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        teacher_name = json["teacher_name"].stringValue
        reason = json["reason"].stringValue
        child_image = json["child_image"].stringValue
        student_detention_id = json["student_detention_id"].stringValue
        child_name = json["child_name"].stringValue
        child_nis = json["child_nis"].stringValue
        school_class = json["school_class"].stringValue
    }
}

class DashboardModelNews: NSObject {
    var news_id = ""
    var news_title = ""
    var news_image = ""
    var news_url = ""
    
    func objectMapping(json: JSON) {
        news_id = json["news_id"].stringValue
        news_title = json["news_title"].stringValue
        news_image = json["news_image"].stringValue
        news_url = json["news_url"].stringValue
    }
}

class DashboardModelSpecialAttentionClass: NSObject {
    var child_nis = ""
    var score_type_id = ""
    var child_name = ""
    var child_id = ""
    var subject_name = ""
    var school_class_id = ""
    var score = ""
    var subject_id = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        child_nis = json["child_nis"].stringValue
        score_type_id = json["score_type_id"].stringValue
        child_name = json["child_name"].stringValue
        child_id = json["child_id"].stringValue
        subject_name = json["subject_name"].stringValue
        school_class_id = json["school_class_id"].stringValue
        score = json["score"].stringValue
        subject_id = json["subject_id"].stringValue
        school_class = json["school_class"].stringValue
    }
}

class DashboardModelSpecialAttentionSubject: NSObject {
    var child_nis = ""
    var score_type_id = ""
    var child_name = ""
    var child_id = ""
    var subject_name = ""
    var school_class_id = ""
    var score = ""
    var subject_id = ""
    var school_class = ""
    
    func objectMapping(json: JSON) {
        child_nis = json["child_nis"].stringValue
        score_type_id = json["score_type_id"].stringValue
        child_name = json["child_name"].stringValue
        child_id = json["child_id"].stringValue
        subject_name = json["subject_name"].stringValue
        school_class_id = json["school_class_id"].stringValue
        score = json["score"].stringValue
        subject_id = json["subject_id"].stringValue
        school_class = json["school_class"].stringValue
    }
}

class DashboardModelEventMonitoring: NSObject {
    var target_type = ""
    var count_total = ""
    var count_reject = ""
    var target_id = ""
    var event_name = ""
    var start_event_date = ""
    var count_pending = ""
    var event_id = ""
    var count_approve = ""
    
    func objectMapping(json: JSON) {
        target_type = json["target_type"].stringValue
        count_total = json["count_total"].stringValue
        count_reject = json["count_reject"].stringValue
        target_id = json["target_id"].stringValue
        event_name = json["event_name"].stringValue
        start_event_date = json["start_event_date"].stringValue
        count_pending = json["count_pending"].stringValue
        event_id = json["event_id"].stringValue
        count_approve = json["count_approve"].stringValue
    }
}

class DashboardModelLatePayment: NSObject {
    var child_name = ""
    var school_class = ""
    var payment_type = ""
    var child_id = ""
    var due_date = ""
    
    func objectMapping(json: JSON) {
        child_name = json["child_name"].stringValue
        school_class = json["school_class"].stringValue
        payment_type = json["payment_type"].stringValue
        child_id = json["child_id"].stringValue
        due_date = json["due_date"].stringValue
    }
}
