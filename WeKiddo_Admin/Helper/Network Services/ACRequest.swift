//
//  ACRequest.swift
//  AYO CLEAN
//
//  Created by Zein Rezky Chandra on 23/05/18.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.


import UIKit
import Alamofire
import SwiftyJSON
import EasyMapping
import SVProgressHUD
import GooglePlaces

class ACRequest: NSObject {

    static func POST_SIGNIN(
        tokenDevice:String,
        phone:String,
        password:String,
        userAgent:String,
        successCompletion:@escaping (LoginModel) -> Void,
        failCompletion:@escaping (String) -> Void){
        let parameters:Parameters = [
            "token_device":tokenDevice,
            "phone":"6281274164293",
            "password":"12345",
            "user_agent":"ios"
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        ACAPI.POST(url: "\(ACUrl.PARENT_LOGIN)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print("loginjson: \(json)")
            if(json["status"] == "success") {
                let user = LoginModel()
                user.objectMapping(json: json)
                successCompletion(user)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func POST_FORGOT(
        tokenDevice:String,
        phone:String,
        password:String,
        userAgent:String,
        successCompletion:@escaping (LoginModel) -> Void,
        failCompletion:@escaping (String) -> Void){
        let parameters:Parameters = [
            "token_device":tokenDevice,
            "phone":phone,
            "password":password,
            "user_agent":"ios"
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        ACAPI.POST(url: "\(ACUrl.PARENT_LOGIN)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print("loginjson: \(json)")
            if(json["status"] == "success") {
                let user = LoginModel()
                user.objectMapping(json: json)
                successCompletion(user)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func POST_DASHBOARD(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        tokenAccess:String,
        successCompletion:@escaping (DashboardModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "school_id":schoolID,
            "year_id":yearID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                    "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.PARENT_DASHBOARD)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print("json dashboard: \(json)")
            if(json["status"] == "success") {
                let dashboard = DashboardModel()
                dashboard.objectMapping(json: json)
                successCompletion(dashboard)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_TASKLIST_MORE(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        tokenAccess:String,
        successCompletion:@escaping ([TaskListModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "school_id":schoolID,
            "year_id":yearID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.PARENT_TASKLIST_MORE)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            var tasklists = ACData.TASKLISTDATA
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                if let data = json["data"]["tasklist_more"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let tasklist = TaskListModel()
                            tasklist.objectMapping(json: jsonValue)
                            tasklists.append(tasklist)
                        }
                    } else {
                        failCompletion("Have no late payment")
                    }
                }
                successCompletion(tasklists)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ABSENCE_DETAIL(
        userId:String,
        childID:String,
        schoolID:String,
        yearID:String,
        tokenAccess:String,
        successCompletion:@escaping (AbsenceDetailModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "school_id":schoolID,
            "child_id":childID,
            "year_id":yearID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.PARENT_ABSENCE_DETAIL)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_EXAM_TYPE_LIST(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        tokenAccess:String,
        successCompletion:@escaping (ExamTypeModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.EXAM_TYPE_LIST)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                let examType = ExamTypeModel()
                examType.objectMapping(json: json)
                successCompletion(examType)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_EXAM_MAJOR_LIST(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        schoolLevelID:String,
        subjectID:String,
        tokenAccess:String,
        successCompletion:@escaping (ExamMajorModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "school_level_id":schoolLevelID,
            "subject_id":subjectID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.EXAM_MAJOR_LIST)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                let examType = ExamMajorModel()
                examType.objectMapping(json: json)
                successCompletion(examType)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_LATE_PAYMENT_LIST(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        tokenAccess:String,
        successCompletion:@escaping ([LatePaymentListModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.GET_MORE_LATE_PAYMENT)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            var latePayments = ACData.LATEPAYMENTLISTDATA
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                if let data = json["data"]["list_child"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let latePayment = LatePaymentListModel()
                            latePayment.objectMapping(json: jsonValue)
                            latePayments.append(latePayment)
                        }
                    } else {
                        failCompletion("Have no late payment")
                    }
                }
                successCompletion(latePayments)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func POST_LATE_PAYMENT_DETAIL(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        childPaymentID:String,
        tokenAccess:String,
        successCompletion:@escaping (LatePaymentDetailModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "child_payment_id":childPaymentID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.GET_LATE_PAYMENT_DETAIL)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                let dashboard = LatePaymentDetailModel()
                dashboard.objectMapping(json: json)
                successCompletion(dashboard)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_STUDENT_LIST_SCORE_ADD_NEW(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        schoolClassID:String,
        examID:String,
        tokenAccess:String,
        successCompletion:@escaping (ExamRemedyScoreListModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "school_class_id":schoolClassID,
            "exam_id":examID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.EXAM_GET_LIST_STUDENT_FOR_ADD_NEW_SCORE)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                let dashboard = ExamRemedyScoreListModel()
                dashboard.objectMapping(json: json)
                successCompletion(dashboard)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_GET_DATA_FOR_EDIT_EXAM(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        examID:String,
        schoolClassID:String,
        tokenAccess:String,
        successCompletion:@escaping (ExamEditModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "exam_id":examID,
            "school_class_id":schoolClassID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.EXAM_GET_DATA_FOR_EDIT)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                let dashboard = ExamEditModel()
                dashboard.objectMapping(json: json)
                successCompletion(dashboard)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_EXAM_ADD_REMEDY(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        examRemedyID:String,
        title:String,
        remedyDate:String,
        remarks:String,
        examID:String,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "exam_remedy_id":examRemedyID,
            "title":title,
            "remedy_date":remedyDate,
            "remarks":remarks,
            "exam_id":examID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.EXAM_ADD_REMEDY)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_EXAM_CLOSE(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        examID:String,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "exam_id":examID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.EXAM_CLOSE)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }

    static func POST_ADD_NEW_EXAM(
        params:Parameters,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        print(params)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.EXAM_SAVE_NEW)", parameter: params, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ADD_NEW_PAYMENT_LATE(
        params:Parameters,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        print(params)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.ADD_NEW_PAYMENT)", parameter: params, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_UPDATE_NEW_SCORE_EXAM(
        params:Parameters,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        print(params)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.EXAM_UPDATE_EXAM_SCORE)", parameter: params, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_UPDATE_NEW_SCORE_EXAM_REMEDY(
        params:Parameters,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        print(params)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.EXAM_UPDATE_REMEDI_SCORE)", parameter: params, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ADD_NEW_REMEDY_STUDENT_EXAM(
        params:Parameters,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        print(params)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.EXAM_ADD_REMEDY_STUDENT)", parameter: params, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ADD_NEW_SUBJECT_TEACHER_CHAPTER(
        params:Parameters,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        print(params)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.SUBJECT_TEACHER_ADD_NEW)", parameter: params, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }

    static func POST_CHECK_VERSION(
        userAgent:String,
        agentType:String,
        versionCode:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void){
        let parameters:Parameters = [
            "user_agent":userAgent,
            "agent_type":agentType,
            "version_code":versionCode
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        ACAPI.POST(url: ACUrl.CHECK_VERSION, parameter: parameters, header: headers, showHUD: true, completion: {jsonData in
            let json = JSON(jsonData)
            print(json)
            if json["status"] == "success" {
                let forceUpdateStatus = json["data"]["version"]["force_update"].boolValue
                let isUpdateStatus = json["data"]["version"]["is_updated"].boolValue
                UserDefaults.standard.set(forceUpdateStatus, forKey: "isForceUpdate")
                UserDefaults.standard.set(isUpdateStatus, forKey: "isStatusUpdate")
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion("Something went wrong, please try again.")
            }
        })
    }
    
    static func POST_SUBJECT_TEACHER_CHAPTER_DETAIL(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        schoolLevelID:String,
        subjectID:String,
        chapterID:String,
        tokenAccess:String,
        successCompletion:@escaping (SubjectTeacherDetailModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "school_level_id":schoolLevelID,
            "subject_id":subjectID,
            "chapter_id":chapterID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.SUBJECT_TEACHER_CHAPTER_DETAIL)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print("subject teacher detail: \(json)")
            if(json["status"] == "success") {
                let detail = SubjectTeacherDetailModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_SUBJECT_TEACHER_CHAPTER_DETAIL_EDIT(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        schoolLevelID:String,
        subjectID:String,
        chapterID:String,
        tokenAccess:String,
        successCompletion:@escaping (SubjectTeacherDetailModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "school_level_id":schoolLevelID,
            "subject_id":subjectID,
            "chapter_id":chapterID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.GET_EDIT_DATA_SUBJECT_TEACHER_DETAIL)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print("subject teacher detail for edit data: \(json)")
            if(json["status"] == "success") {
                let detail = SubjectTeacherDetailModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_SPECIAL_ATTENTION_DETAIL_BY_SUBJECT(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        subjectID:String,
        childID:String,
        tokenAccess:String,
        successCompletion:@escaping (SpecialAttentionBySubjectDetailModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "child_id":childID,
            "subject_id":subjectID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.GET_SPECIAL_ATTENTION_DETAIL_BY_SUBJECT)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                let detaildata = SpecialAttentionBySubjectDetailModel()
                detaildata.objectMapping(json: json)
                successCompletion(detaildata)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_SPECIAL_ATTENTION_DETAIL_BY_CLASS(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        classID:String,
        childID:String,
        tokenAccess:String,
        successCompletion:@escaping (SpecialAttentionByClassDetailModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "child_id":childID,
            "class_id":classID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.GET_SPECIAL_ATTENTION_DETAIL_BY_CLASS)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                let detaildata = SpecialAttentionByClassDetailModel()
                detaildata.objectMapping(json: json)
                successCompletion(detaildata)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_FEEDBACK(
        params:Parameters,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        print(params)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.POST_SCHOOL_FEEDBACK)", parameter: params, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ADMIN_DETAIL_EVENT(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        eventID:String,
        tokenAccess:String,
        successCompletion:@escaping (ApprovalDetailModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "event_id":eventID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.ADMIN_GET_DETAIL_EVENT)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                let dashboard = ApprovalDetailModel()
                dashboard.objectMapping(json: json)
                successCompletion(dashboard)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ADMIN_EVENT_COUNT_BY_CLASS(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        eventID:String,
        schoolClassID:String,
        tokenAccess:String,
        successCompletion:@escaping (EventCountModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "event_id":eventID,
            "target_id":schoolClassID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.ADMIN_GET_SPECIFIC_EVENT_COUNT)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                let dashboard = EventCountModel()
                dashboard.objectMapping(json: json)
                successCompletion(dashboard)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_UPDATE_PAYMENT_DETAIL(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        childPaymentID:String,
        paymentDate:String,
        paymentNotes:String,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "child_payment_id":childPaymentID,
            "payment_notes":paymentNotes,
            "payment_date":paymentDate
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.UPDATE_STATUS_PAYMENT)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_TEACHER_PROFILE(
        userId:String,
        schoolID:String,
        role:String,
        yearID:String,
        tokenAccess:String,
        successCompletion:@escaping (ParentProfileModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "school_id":schoolID,
            "role":role,
            "year_id":yearID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.PARENT_TEACHER_PROFILE)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                let dashboard = ParentProfileModel()
                dashboard.objectMapping(json: json)
                successCompletion(dashboard)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_TEACHER_SPECIAL_ATTENTION_BY_SUBJECT(
        userId:String,
        schoolID:String,
        role:String,
        yearID:String,
        tokenAccess:String,
        successCompletion:@escaping ([SpecialAttentionBySubjectListModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "school_id":schoolID,
            "role":role,
            "year_id":yearID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.GET_SPECIAL_ATTENTION_BY_SUBJECT)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            var specialAttentionModels = ACData.SPECIALATTENTIONBYSUBJECTDATA
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                if let data = json["data"]["special_attention_list"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let specialAttentionModel = SpecialAttentionBySubjectListModel()
                            specialAttentionModel.objectMapping(json: jsonValue)
                            specialAttentionModels.append(specialAttentionModel)
                        }
                    } else {
                        failCompletion("Have no special attention data")
                    }
                }
                successCompletion(specialAttentionModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func POST_TEACHER_SPECIAL_ATTENTION_BY_CLASS(
        userId:String,
        schoolID:String,
        role:String,
        yearID:String,
        tokenAccess:String,
        successCompletion:@escaping ([SpecialAttentionByClassListModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "school_id":schoolID,
            "role":role,
            "year_id":yearID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.GET_SPECIAL_ATTENTION_BY_CLASS)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            var specialAttentionModels = ACData.SPECIALATTENTIONBYCLASSDATA
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                if let data = json["data"]["special_attention_list"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let specialAttentionModel = SpecialAttentionByClassListModel()
                            specialAttentionModel.objectMapping(json: jsonValue)
                            specialAttentionModels.append(specialAttentionModel)
                        }
                    } else {
                        failCompletion("Have no special attention data")
                    }
                }
                successCompletion(specialAttentionModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func POST_ATTENDANCE_LIST(
        userId:String,
        role:String,
        tokenAccess:String,
        successCompletion:@escaping ([AttendanceModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.TEACHER_GET_ATTENDANCE)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            var attendanceModels = ACData.ATTENDANCEDATA
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                if let data = json["data"]["attendance"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let attendanceModel = AttendanceModel()
                            attendanceModel.objectMapping(json: jsonValue)
                            attendanceModels.append(attendanceModel)
                        }
                    } else {
                        failCompletion("Have no attendance")
                    }
                }
                successCompletion(attendanceModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func POST_DETAIL_ATTENDANCE(
        userId:String,
        role:String,
        tokenAccess:String,
        schoolSessionID:String,
        successCompletion:@escaping (AttendanceDetailModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_session_id":schoolSessionID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.TEACHER_GET_DETAIL_ATTENDANCE)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                let detail = AttendanceDetailModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_TEACHER_UPDATE_STUDENT_ATTENDANCE(
        userId:String,
        role:String,
        schoolSessionId:String,
        childId:String,
        isAttend:Int,
        attendanceType:Int,
        note:String,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_session_id":schoolSessionId,
            "child_id":childId,
            "is_attend":isAttend,
            "attendance_type":attendanceType,
            "note":note
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.TEACHER_UPDATE_STUDENT_ATTENDANCE_STATUS)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ADD_NEW_ATTACHMENT_FILE_VOICE_SUBJECT_TEACHER(
        parameters: Parameters,
        file:URL?,
        fileName:String,
        fileParameter:String,
        tokenAccess:String,
        successCompletion: @escaping ([SubjectTeacherVoiceNotesArrayModel]) -> Void,
        failCompletion: @escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"multipart/form-data; boundary=null",
                                   "Authorization":"Bearer \(tokenAccess)"]
        if let takenFile = file {
            ACAPI.POST_WITH_UPLOAD_IMAGE(url: "\(ACUrl.SUBJECT_TEACHER_UPLOAD_FILE)", parameter: parameters, file: takenFile, fileName: fileName, fileParameter: fileParameter, showHUD: true, header: headers) { (jsonData) in
                let json = JSON(jsonData)
//                SUBJECTTEACHERDATACHMENTDATAMODEL
                var attachmentModels = ACData.SUBJECTTEACHERDATAVOICENOTEMODEL
                print(json)
                if(json["status"] == "success") {
                    let attacmentModel = SubjectTeacherVoiceNotesArrayModel()
                    attacmentModel.objectMapping(json: json)
                    attachmentModels.append(attacmentModel)
                    successCompletion(attachmentModels)
                } else {
                    failCompletion(json["status"].stringValue)
                }
            }
        }
    }

    static func POST_ADD_NEW_ATTACHMENT_FILE_SUBJECT_TEACHER(
        parameters: Parameters,
        file:Data,
        fileName:String,
        fileParameter:String,
        tokenAccess:String,
        mimeType:String,
        successCompletion: @escaping ([SubjectTeacherAttachmentArrayModel]) -> Void,
        failCompletion: @escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"multipart/form-data; boundary=null",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST_WITH_UPLOAD_VIDEO(url: "\(ACUrl.SUBJECT_TEACHER_UPLOAD_FILE)", parameter: parameters, file: file, fileName: fileName, fileParameter: fileParameter, mimeType: "", showHUD: true, header: headers) { (jsonData) in
            let json = JSON(jsonData)
            var attachmentModels = ACData.SUBJECTTEACHERDATATACHMENTDATAMODEL
            print(json)
            if(json["status"] == "success") {
                let attacmentModel = SubjectTeacherAttachmentArrayModel()
                attacmentModel.objectMapping(json: json)
                attachmentModels.append(attacmentModel)
                successCompletion(attachmentModels)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_UPLOAD_NEW_ATTACHMENT_SUBJECT_TEACHER(
        parameters: Parameters,
        file:UIImage,
        fileName:String,
        fileParameter:String,
        tokenAccess:String,
        successCompletion: @escaping ([AttachmentBannerModel]) -> Void,
        failCompletion: @escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"multipart/form-data; boundary=null",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST_WITH_IMAGE(url: "\(ACUrl.POST_UPLOAD_ATTACHMENT_MEDIA_ANNOUNCEMENT)", parameter: parameters, imageFile: file, imageFileName: fileName, imageParameter: fileParameter, showHUD: true, header: headers) { (jsonData) in
            let jsonValue = JSON(jsonData)
            var attachmentModels = ACData.ATTACHMENTBANNERDATA
            print(jsonValue)
            if(jsonValue["status"] == "success") {
                let attacmentModel = AttachmentBannerModel()
                attacmentModel.objectMapping(json: jsonValue)
                attachmentModels.append(attacmentModel)
                successCompletion(attachmentModels)
            } else {
                failCompletion(jsonValue["status"].stringValue)
            }
        }
    }
    
    static func POST_ADD_NEW_ATTACHMENT(
        userId:String,
        school_user_id:String,
        assignID:String,
        mediaType:String,
        mediaFile:String,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "school_user_id":school_user_id,
            "assign_id":assignID,
            "media_type":mediaType,
            "media_file":mediaFile
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.ADMIN_POST_ASSIGNMENT_SAVE_ATTACHMENT)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ADD_NEW_ATTACHMENT_FILE(
        parameters: Parameters,
        file:URL?,
        fileName:String,
        fileParameter:String,
        tokenAccess:String,
        successCompletion: @escaping (String) -> Void,
        failCompletion: @escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"multipart/form-data; boundary=null",
                                   "Authorization":"Bearer \(tokenAccess)"]
        if let takenFile = file {
            ACAPI.POST_WITH_UPLOAD_IMAGE(url: "\(ACUrl.ADMIN_POST_ASSIGNMENT_SAVE_ATTACHMENT)", parameter: parameters, file: takenFile, fileName: fileName, fileParameter: fileParameter, showHUD: true, header: headers) { (jsonData) in
                let json = JSON(jsonData)
                print(json)
                if(json["status"] == "success") {
                    successCompletion(json["status"].stringValue)
                } else {
                    failCompletion(json["status"].stringValue)
                }
            }
        }
    }
    
    static func POST_UPLOAD_NEW_VIDEO_ATTACHMENT_EVENT_MONITORING(
        parameters: Parameters,
        file:Data?,
        fileName:String,
        fileParameter:String,
        tokenAccess:String,
        successCompletion: @escaping ([AttachmentVideoMediaModel]) -> Void,
        failCompletion: @escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"multipart/form-data; boundary=null",
                                   "Authorization":"Bearer \(tokenAccess)"]
        if let takenFile = file {
            ACAPI.POST_WITH_UPLOAD_VIDEO(url: "\(ACUrl.ADMIN_EVENT_MONITORING_ADD_GALLERY)", parameter: parameters, file: takenFile, fileName: fileName, fileParameter: fileParameter, mimeType: "video/mov", showHUD: true, header: headers) { (jsonData) in
                let jsonValue = JSON(jsonData)
                var attachmentModels = ACData.ATTACHMENTVIDEOMEDIADATA
                print(jsonValue)
                if(jsonValue["status"] == "success") {
                    let attacmentModel = AttachmentVideoMediaModel()
                    attacmentModel.objectMapping(json: jsonValue)
                    attachmentModels.append(attacmentModel)
                    successCompletion(attachmentModels)
                } else {
                    failCompletion(jsonValue["status"].stringValue)
                }
            }
        }
    }

    static func POST_UPLOAD_FILE_EVENT_VIDEO_ATTACHMENT_EVENT_MONITORING(
        parameters: Parameters,
        file:Data?,
        fileName:String,
        fileParameter:String,
        tokenAccess:String,
        successCompletion: @escaping ([AttachmentVideoMediaModel]) -> Void,
        failCompletion: @escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"multipart/form-data; boundary=null",
                                   "Authorization":"Bearer \(tokenAccess)"]
        if let takenFile = file {
            ACAPI.POST_WITH_UPLOAD_VIDEO(url: "\(ACUrl.ADMIN_EVENT_MONITORING_UPLOAD_FILE_EVENT)", parameter: parameters, file: takenFile, fileName: fileName, fileParameter: fileParameter, mimeType: "video/mov", showHUD: true, header: headers) { (jsonData) in
                let jsonValue = JSON(jsonData)
                var attachmentModels = ACData.ATTACHMENTVIDEOMEDIADATA
                print(jsonValue)
                if(jsonValue["status"] == "success") {
                    let attacmentModel = AttachmentVideoMediaModel()
                    attacmentModel.objectMapping(json: jsonValue)
                    attachmentModels.append(attacmentModel)
                    successCompletion(attachmentModels)
                } else {
                    failCompletion(jsonValue["status"].stringValue)
                }
            }
        }
    }
    
    static func POST_UPLOAD_NEW_VIDEO_ATTACHMENT_ANNOUNCEMENT(
        parameters: Parameters,
        file:Data?,
        fileName:String,
        fileParameter:String,
        tokenAccess:String,
        successCompletion: @escaping ([AttachmentVideoMediaModel]) -> Void,
        failCompletion: @escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"multipart/form-data; boundary=null",
                                   "Authorization":"Bearer \(tokenAccess)"]
        if let takenFile = file {
            ACAPI.POST_WITH_UPLOAD_VIDEO(url: "\(ACUrl.POST_UPLOAD_ATTACHMENT_MEDIA_ANNOUNCEMENT)", parameter: parameters, file: takenFile, fileName: fileName, fileParameter: fileParameter, mimeType: "video/mov", showHUD: true, header: headers) { (jsonData) in
                let jsonValue = JSON(jsonData)
                var attachmentModels = ACData.ATTACHMENTVIDEOMEDIADATA
                print(jsonValue)
                if(jsonValue["status"] == "success") {
                    let attacmentModel = AttachmentVideoMediaModel()
                    attacmentModel.objectMapping(json: jsonValue)
                    attachmentModels.append(attacmentModel)
                    successCompletion(attachmentModels)
                } else {
                    failCompletion(jsonValue["status"].stringValue)
                }
            }
        }
    }
    
    static func POST_ASSIGNMENT_CLOSE(
        userId:String,
        school_user_id:String,
        assignID:String,
        classID:String,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "school_user_id":school_user_id,
            "assign_id":assignID,
            "class_id":classID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.ADMIN_POST_ASSIGNMENT_CLOSE)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_DELETE_ATTACHMENT_ASSIGNMENT(
        userId:String,
        school_user_id:String,
        attachmentID:Int,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "school_user_id":school_user_id,
            "attachment_id":attachmentID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.ADMIN_POST_ASSIGNMENT_DELETE_ATTACHMENT)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_DETAIL_ASSIGNMENT_FOR_EDIT(
        userId:String,
        school_user_id:String,
        assignID:String,
        school_id:String,
        year_id:String,
        tokenAccess:String,
        successCompletion:@escaping (AssignmentDetailEditModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "school_user_id":school_user_id,
            "assign_id":assignID,
            "school_id":school_id,
            "year_id":year_id
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.ADMIN_GET_ASSIGNMENT_EDIT)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                let detail = AssignmentDetailEditModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_DETENTION_LISTS(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        tokenAccess:String,
        successCompletion:@escaping ([DetentionModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.POST_DETENTION_LIST)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            var detentionModels = ACData.DETENTIONDATA
            print(json)
            if(json["status"] == "success") {
                if let data = json["data"]["detention_list"]["detention_group"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let detentionModel = DetentionModel()
                            detentionModel.objectMapping(json: jsonValue)
                            detentionModels.append(detentionModel)
                        }
                    } else {
                        failCompletion("Have no detention")
                    }
                }
                successCompletion(detentionModels)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_TEACHER_ON_DUTY_CHILD_LIST(
        schoolClassID:String,
        schoolID:String,
        yearID:String,
        userId:String,
        role:String,
        tokenAccess:String,
        successCompletion:@escaping (TeacherOnDutyChildListModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "school_class_id":schoolClassID,
            "school_id":schoolID,
            "year_id":yearID,
            "user_id":userId,
            "role":role,
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.POST_GET_TEACHER_ON_DUTY_CHILD_LIST)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                let child = TeacherOnDutyChildListModel()
                child.objectMapping(json: json)
                successCompletion(child)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_TEACHER_ON_DUTY_PICKER_LIST(
        schoolID:String,
        yearID:String,
        userId:String,
        role:String,
        tokenAccess:String,
        successCompletion:@escaping (TeacherOnDutyChildListPickerModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "school_id":schoolID,
            "year_id":yearID,
            "user_id":userId,
            "role":role,
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.POST_GET_TEACHER_ON_DUTY_PICKER_LIST)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                let picker = TeacherOnDutyChildListPickerModel()
                picker.objectMapping(json: json)
                successCompletion(picker)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }

    static func POST_SEARCH_STUDENT_LISTS_AT_EVENT(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        eventID:String,
        targetID:String,
        keyword:String,
        tokenAccess:String,
        successCompletion:@escaping ([StudentSearchModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "event_id":eventID,
            "target_id":targetID,
            "keyword":keyword
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.GET_CHILD_EVENT_SEARCH)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            var searchModels = ACData.STUDENTSEARCHDATA
            print(json)
            if(json["status"] == "success") {
                if let data = json["data"]["children"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let searchModel = StudentSearchModel()
                            searchModel.objectMapping(json: jsonValue)
                            searchModels.append(searchModel)
                        }
                    } else {
                        failCompletion("Have no student")
                    }
                }
                successCompletion(searchModels)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_SEARCH_STUDENT_LISTS(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        keyword:String,
        tokenAccess:String,
        successCompletion:@escaping ([StudentSearchModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "keyword":keyword
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.POST_SEARCH_STUDENT)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            var searchModels = ACData.STUDENTSEARCHDATA
            print(json)
            if(json["status"] == "success") {
                if let data = json["data"]["search_student"]["result_list"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let searchModel = StudentSearchModel()
                            searchModel.objectMapping(json: jsonValue)
                            searchModels.append(searchModel)
                        }
                    } else {
                        failCompletion("Have no student")
                    }
                }
                successCompletion(searchModels)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ANNOUNCEMENT_SEARCH_STUDENT_LISTS(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        classID:String,
        keyword:String,
        tokenAccess:String,
        successCompletion:@escaping ([StudentSearchModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "class_id":classID,
            "keyword":keyword
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.POST_ANNOUNCEMENT_SEARCH_STUDENT)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            var searchModels = ACData.STUDENTSEARCHDATA
            print(json)
            if(json["status"] == "success") {
                if let data = json["data"]["search_student"]["result_list"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let searchModel = StudentSearchModel()
                            searchModel.objectMapping(json: jsonValue)
                            searchModels.append(searchModel)
                        }
                    } else {
                        failCompletion("Have no student")
                    }
                }
                successCompletion(searchModels)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ADD_NEW_ANNOUNCEMENT_STUDENT(
        params:Parameters,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        print(params)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.POST_ANNOUNCEMENT_ADD)", parameter: params, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_SAVE_EVENT_PAYMENT_STUDENT(
        params:Parameters,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        print(params)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.SAVE_EVENT_PAYMENT)", parameter: params, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ADD_NEW_EVENT(
        params:Parameters,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        print(params)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.ADMIN_ADD_EVENT)", parameter: params, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ADD_STUDENT_DETENTION(
        params:Parameters,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        print(params)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.POST_ADD_DETENTION)", parameter: params, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_CONFIRM_CLASS_ATTENDANCE(
        userId:String,
        role:String,
        schoolSessionId:String,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_session_id":schoolSessionId
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.TEACHER_CONFIRM_ATTENDANCE)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_PERMISSION_DETAIL(
        userId:String,
        role:String,
        permissionID:String,
        tokenAccess:String,
        successCompletion:@escaping (PermissionDataModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "permission_id":permissionID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.TEACHER_GET_PERMISSION_DETAIL)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                let detail = PermissionDataModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_UPDATE_PERMISSION(
        userId:String,
        role:String,
        permissionID:String,
        tokenAccess:String,
        action:Int,
        reason:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "permission_id":permissionID,
            "action":action,
            "permission_reason":reason
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.TEACHER_UPDATE_PERMISSION_STATUS)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func SCHOOL_GET_MORE_NEWS(
        userId:String,
        role:String,
        schoolID:String,
        yearID:String,
        tokenAccess:String,
        successCompletion:@escaping ([ParentNewsModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.SCHOOL_GET_MORE_NEWS)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            var newsModels = ACData.PARENTNEWSCONTENT
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                if let data = json["data"]["list_news"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let newsModel = ParentNewsModel()
                            newsModel.objectMapping(json: jsonValue)
                            newsModels.append(newsModel)
                        }
                    } else {
                        failCompletion("Have no news")
                    }
                }
                successCompletion(newsModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func POST_PERMISSION_LIST(
        userId:String,
        role:String,
        tokenAccess:String,
        successCompletion:@escaping (PermissionModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role
        ]
        print(parameters)
        print(tokenAccess)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.TEACHER_GET_PERMISSION)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                let detail = PermissionModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_SEARCH_PERMISSION_LIST(
        userId:String,
        role:String,
        key:String,
        tokenAccess:String,
        successCompletion:@escaping (PermissionModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "role":role,
            "key":key
        ]
        print(parameters)
        print(tokenAccess)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.SEARCH_PERMISSION)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                let detail = PermissionModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ASSIGNMENT_LIST(
        userId:String,
        schoolId:String,
        yearId:String,
        school_user_id:String,
        tokenAccess:String,
        successCompletion:@escaping (AssignmentListModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "school_id":schoolId,
            "year_id":yearId,
            "school_user_id":school_user_id
        ]
        print(parameters)
        print(tokenAccess)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.ADMIN_GET_ASSIGNMENT_LIST)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                let detail = AssignmentListModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ASSIGNMENT_TEACHER_LIST(
        userId:String,
        schoolId:String,
        yearId:String,
        tokenAccess:String,
        successCompletion:@escaping (AssignmentTeacherListAllModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "school_id":schoolId,
            "year_id":yearId
        ]
        print(parameters)
        print(tokenAccess)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.ADMIN_GET_ASSIGNMENT_TEACHER_LIST)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                let detail = AssignmentTeacherListAllModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ASSIGNMENT_GET_TEACHER(
        userId:String,
        schoolId:String,
        yearId:String,
        tokenAccess:String,
        successCompletion:@escaping (AssignmentTeacherListModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "school_id":schoolId,
            "year_id":yearId
        ]
        print(parameters)
        print(tokenAccess)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.ADMIN_GET_ASSIGNMENT_GET_TEACHER)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                let detail = AssignmentTeacherListModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ASSIGNMENT_GET_SUBJECT(
        userId:String,
        schoolId:String,
        yearId:String,
        school_user_id: String,
        tokenAccess:String,
        successCompletion:@escaping (AssignmentSubjectListModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "school_id":schoolId,
            "year_id":yearId,
            "school_user_id":school_user_id
        ]
        print(parameters)
        print(tokenAccess)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.ADMIN_GET_ASSIGNMENT_GET_SUBJECT_CLASS)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                let detail = AssignmentSubjectListModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ASSIGNMENT_GET_CHAPTER_LIST(
        userId:String,
        schoolId:String,
        yearId:String,
        school_user_id: String,
        subject_id: String,
        tokenAccess:String,
        successCompletion:@escaping (AssignmentChapterListModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "school_id":schoolId,
            "year_id":yearId,
            "school_user_id":school_user_id,
            "subject_id":subject_id
        ]
        print(parameters)
        print(tokenAccess)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.ADMIN_GET_ASSIGNMENT_GET_CHAPTER)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                let detail = AssignmentChapterListModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ATTACHMENT_ASSIGNMENT_DETAIL(
        userId:String,
        school_user_id:String,
        assignID:String,
        tokenAccess:String,
        successCompletion:@escaping (AttachmentModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters: Parameters = [
            "user_id":userId,
            "school_user_id":school_user_id,
            "assign_id":assignID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.ADMIN_GET_ASSIGNMENT_GET_ATTACHMENT)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                let detail = AttachmentModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ASSIGNMENT_DETAIL(
        userId:String,
        school_user_id:String,
        assignID:String,
        classID:String,
        tokenAccess:String,
        successCompletion:@escaping (AssignmentDetailModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters: Parameters = [
            "user_id":userId,
            "school_user_id":school_user_id,
            "assign_id":assignID,
            "class_id":classID
        ]
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.ADMIN_GET_ASSIGNMENT_DETAIL)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            if(json["status"] == "success"){
                let detail = AssignmentDetailModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_SUBJECT_LIST(
        userId:String,
        school_user_id:String,
        school_id:String,
        year_id:String,
        tokenAccess:String,
        successCompletion:@escaping ([SubjectModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userId,
            "school_user_id":school_user_id,
            "school_id":school_id,
            "year_id":year_id
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.ADMIN_GET_ASSIGNMENT_GET_SUBJECT_CLASS)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            var subjectModels = ACData.SUBJECTDATA
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                if let data = json["data"]["subject_class_list"]["subject_list"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let subjectModel = SubjectModel()
                            subjectModel.objectMapping(json: jsonValue)
                            subjectModels.append(subjectModel)
                        }
                    } else {
                        failCompletion("Have no attendance")
                    }
                }
                successCompletion(subjectModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func POST_CHAPTER_LIST(
        userId:String,
        role:String,
        subjectID:String,
        tokenAccess:String,
        successCompletion:@escaping (ChapterModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters: Parameters = [
            "user_id":userId,
            "role":role,
            "subject_id":subjectID
        ]
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.GET_CHAPTER_LIST)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                let detail = ChapterModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_SCORE_LIST(
        userId:String,
        school_user_id:String,
        school_id:String,
        year_id:String,
        assignID:String,
        classID:String,
        tokenAccess:String,
        successCompletion:@escaping (ScoreListModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters: Parameters = [
            "user_id":userId,
            "school_user_id":school_user_id,
            "school_id":school_id,
            "year_id":year_id,
            "assign_id":assignID,
            "class_id":classID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.ADMIN_GET_ASSIGNMENT_GET_SCORE)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                let detail = ScoreListModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ADD_NEW_ASSIGNMENT(
        params:Parameters,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.ADMIN_POST_ASSIGNMENT_SAVE)", parameter: params, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_ADD_TEACHER_ON_DUTY_PERMISSION(
        params:Parameters,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.POST_ADD_TEACHER_ON_DUTY_PERMISSION)", parameter: params, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_UPDATE_SCORE(
        params:Parameters,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.ADMIN_POST_ASSIGNMENT_SAVE_SCORE)", parameter: params, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func GET_EXAM_LIST(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        levelID:String,
        subjectID:String,
        tokenAccess:String,
        successCompletion:@escaping (ExamListDataModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters: Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "level_id":levelID,
            "subject_id":subjectID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.GET_EXAM_SCHEDULE_LIST)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                let examList = ExamListDataModel()
                examList.objectMapping(json: json)
                successCompletion(examList)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func GET_EXAM_DETAIL(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        examID:String,
        tokenAccess:String,
        successCompletion:@escaping (ExamDetailModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters: Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "exam_id":examID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.GET_EXAM_SCHEDULE_DETAIL)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                let examList = ExamDetailModel()
                examList.objectMapping(json: json)
                successCompletion(examList)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func GET_EXAM_REMEDY_SCORE_LIST(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        schoolClassID:String,
        examRemedyID:String,
        tokenAccess:String,
        successCompletion:@escaping (ExamRemedyScoreListModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters: Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "school_class_id":schoolClassID,
            "exam_remedy_id":examRemedyID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.GET_EXAM_SCORE_REMEDY)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                let examList = ExamRemedyScoreListModel()
                examList.objectMapping(json: json)
                successCompletion(examList)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func GET_HOME_DATA(
        childID:String,
        successCompletion:@escaping (HomeGeneralDataModel, CurrentSessionModel, [AssignmentModel], [AnnouncementModel], [SessionsModel], [NewsModel], [ExamsModel], [CourseListModel], [TabbarsMenuModel]) -> Void,
        failCompletion:@escaping (String) -> Void){
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_HOME_DATA)child_id=\(childID)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_HOME_DATA)child_id=\(childID)", header: headers, showHUD: true) { (jsonData) in
            
            var examModels = ACData.EXAMDATA
            var assignmentsModels = ACData.ASSIGNMENT
            var announcementsModels = ACData.ANNOUNCEMENT
            var sessionsModelss = ACData.SESSIONS
            var newsModels = ACData.NEWSCONTENT
            var courseModels = ACData.COURSELISTDATA
            var tabbarsModels = ACData.TABBARMENUDATA
            
            let json = JSON(jsonData)
            print(json)
            
            if(json["status"] == "success"){
                let homeData = HomeGeneralDataModel()
                homeData.objectMapping(json: json)
                let currentSessionData = CurrentSessionModel()
                currentSessionData.objectMapping(json: json)
                if let data = json["information"]["Assignment"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let assigntmentModel = AssignmentModel()
                            assigntmentModel.objectMapping(json: jsonValue)
                            assignmentsModels.append(assigntmentModel)
                        }
                    } else {
                        //                        failCompletion("Have no assignment")
                    }
                }
                if let data = json["information"]["Announcement"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let announcementModel = AnnouncementModel()
                            announcementModel.objectMapping(json: jsonValue)
                            announcementsModels.append(announcementModel)
                        }
                    } else {
                        //                        failCompletion("Have no announcement")
                    }
                }
                if let data = json["information"]["sessions"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let sessionData = SessionsModel()
                            sessionData.objectMapping(json: jsonValue)
                            sessionsModelss.append(sessionData)
                        }
                    } else {
                        //                        failCompletion("Have no session")
                    }
                }
                if let data = json["information"]["News"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let newsData = NewsModel()
                            newsData.objectMapping(json: jsonValue)
                            newsModels.append(newsData)
                        }
                    } else {
                        //                        failCompletion("Have no news")
                    }
                }
                if let data = json["information"]["exams"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let examData = ExamsModel()
                            examData.objectMapping(json: jsonValue)
                            examModels.append(examData)
                        }
                    } else {
                        
                    }
                }
                if let data = json["information"]["course"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let courseData = CourseListModel()
                            courseData.objectMapping(json: jsonValue)
                            courseModels.append(courseData)
                        }
                    } else {
                        //                        failCompletion("Have no course")
                    }
                }
                if let data = json["information"]["child"]["navbars"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let tabMenuData = TabbarsMenuModel()
                            tabMenuData.objectMapping(json: jsonValue)
                            tabbarsModels.append(tabMenuData)
                        }
                    } else {
                        //                        failCompletion(json["message"].stringValue)
                    }
                }
                successCompletion(homeData, currentSessionData, assignmentsModels, announcementsModels, sessionsModelss, newsModels, examModels, courseModels, tabbarsModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_SESSION_DETAIL(
        subjectSessionId:String,
        successCompletion:@escaping (SessionDetailModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        print("url: \(ACUrl.PARENT_GET_SESSION_DETAIL)school_class_session_id=\(subjectSessionId)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_SESSION_DETAIL)school_class_session_id=\(subjectSessionId)", header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if json["status"] == "success" {
                let detail = SessionDetailModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_ATTACHMENT(
        schoolAssignmentID:String,
        successCompletion:@escaping ([AttachmentModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
//        let headers:HTTPHeaders = ["Content-Type":"application/json"]
//        //print("url: \(ACUrl.PARENT_GET_ANNOUNCEMENT)child_id=\(childID)")
//        ACAPI.GET(url: "\(ACUrl.PARENT_GET_ASSIGNMENT_ATTACHMENT)school_assignment_id=\(schoolAssignmentID)", header: headers, showHUD: true) { (jsonData) in
//            var attachmentModels = ACData.ATTACHMENTDATA
//            let json = JSON(jsonData)
//            print("attachment data: \(json)")
//            if(json["status"] == "success") {
//                if let data = json["attachments"].array {
//                    if data.count > 0 {
//                        for jsonValue in data {
//                            let attachmentModel = AttachmentModel()
//                            attachmentModel.objectMapping(json: jsonValue)
//                            attachmentModels.append(attachmentModel)
//                        }
//                    } else {
//                        failCompletion("Have no attachment")
//                    }
//                }
//                successCompletion(attachmentModels)
//            } else {
//                failCompletion(json["message"].stringValue)
//            }
//        }
    }
    
    static func POST_NEW_PERMISSION(
        child_id:String,
        permission_date:String,
        permission_type:String,
        permission_reason:String,
        attachment:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
        let parameters: Parameters = [
            "child_id":child_id,
            "permission_date":permission_date,
            "permission_type":permission_type,
            "permission_reason":permission_reason,
            "attachment":attachment
        ]
        print(parameters)
        print("\(ACUrl.PARENT_ADD_NEW_PERMSSION)")
        ACAPI.POST(url: "\(ACUrl.PARENT_ADD_NEW_PERMSSION)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if json["status"] == "success" {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func GET_ANNOUNCEMENT_DATA(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        accessToken:String,
        successCompletion:@escaping ([AnnouncementListModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(accessToken)"]
        ACAPI.POST(url: "\(ACUrl.POST_ANNOUNCEMENT_LISTS)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            var announcementModels = ACData.ANNOUNCEMENTLISTDATA
            print(json)
            if(json["status"] == "success") {
                if let data = json["data"]["announcement_list"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let announcementModel = AnnouncementListModel()
                            announcementModel.objectMapping(json: jsonValue)
                            announcementModels.append(announcementModel)
                        }
                    } else {
                        failCompletion("Have no announcement")
                    }
                }
                successCompletion(announcementModels)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func GET_ANNOUNCEMENT_LEVEL_DATA(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        accessToken:String,
        successCompletion:@escaping ([AnnouncementLevelListModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(accessToken)"]
        ACAPI.POST(url: "\(ACUrl.POST_ADD_ANNOUNCEMENT_LEVEL_LIST)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            var announcementModels = ACData.ANNOUNCEMENTLEVELLISTDATA
            print(json)
            if(json["status"] == "success") {
                if let data = json["data"]["level_list"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let announcementModel = AnnouncementLevelListModel()
                            announcementModel.objectMapping(json: jsonValue)
                            announcementModels.append(announcementModel)
                        }
                    } else {
                        failCompletion("Have no announcement")
                    }
                }
                successCompletion(announcementModels)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func GET_ANNOUNCEMENT_CLASS_DATA(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        levelID:String,
        accessToken:String,
        successCompletion:@escaping ([AnnouncementClassDataModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "level_id":levelID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(accessToken)"]
        ACAPI.POST(url: "\(ACUrl.POST_ADD_ANNOUNCEMENT_CLASS_LIST)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            var announcementModels = ACData.ANNOUNCEMENTCLASSDATA
            print(json)
            if(json["status"] == "success") {
                if let data = json["data"]["class_list"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let announcementModel = AnnouncementClassDataModel()
                            announcementModel.objectMapping(json: jsonValue)
                            announcementModels.append(announcementModel)
                        }
                    } else {
                        failCompletion("Have no class")
                    }
                }
                successCompletion(announcementModels)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_UPLOAD_NEW_ATTACHMENT_ANNOUNCEMENT(
        parameters: Parameters,
        file:UIImage,
        fileName:String,
        fileParameter:String,
        tokenAccess:String,
        successCompletion: @escaping ([AttachmentBannerModel]) -> Void,
        failCompletion: @escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"multipart/form-data; boundary=null",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST_WITH_IMAGE(url: "\(ACUrl.POST_UPLOAD_ATTACHMENT_MEDIA_ANNOUNCEMENT)", parameter: parameters, imageFile: file, imageFileName: fileName, imageParameter: fileParameter, showHUD: true, header: headers) { (jsonData) in
            let jsonValue = JSON(jsonData)
            var attachmentModels = ACData.ATTACHMENTBANNERDATA
            print(jsonValue)
            if(jsonValue["status"] == "success") {
                let attacmentModel = AttachmentBannerModel()
                attacmentModel.objectMapping(json: jsonValue)
                attachmentModels.append(attacmentModel)
                successCompletion(attachmentModels)
            } else {
                failCompletion(jsonValue["status"].stringValue)
            }
        }
    }
    
    static func POST_UPLOAD_NEW_IMAGE_ATTACHMENT_EVENT_MONITORING(
        parameters: Parameters,
        file:UIImage,
        fileName:String,
        fileParameter:String,
        tokenAccess:String,
        successCompletion: @escaping ([AttachmentBannerModel]) -> Void,
        failCompletion: @escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"multipart/form-data; boundary=null",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST_WITH_IMAGE(url: "\(ACUrl.ADMIN_EVENT_MONITORING_ADD_GALLERY)", parameter: parameters, imageFile: file, imageFileName: fileName, imageParameter: fileParameter, showHUD: true, header: headers) { (jsonData) in
            let jsonValue = JSON(jsonData)
            var attachmentModels = ACData.ATTACHMENTBANNERDATA
            print(jsonValue)
            if(jsonValue["status"] == "success") {
                let attacmentModel = AttachmentBannerModel()
                attacmentModel.objectMapping(json: jsonValue)
                attachmentModels.append(attacmentModel)
                successCompletion(attachmentModels)
            } else {
                failCompletion(jsonValue["status"].stringValue)
            }
        }
    }

    static func POST_UPLOAD_NEW_IMAGE_ATTACHMENT_FEEDBACK(
        parameters: Parameters,
        file:UIImage,
        fileName:String,
        fileParameter:String,
        tokenAccess:String,
        successCompletion: @escaping ([AttachmentImageMediaModel]) -> Void,
        failCompletion: @escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"multipart/form-data; boundary=null",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST_WITH_IMAGE(url: "\(ACUrl.POST_MEDIA_FILE_FEEDBACK)", parameter: parameters, imageFile: file, imageFileName: fileName, imageParameter: fileParameter, showHUD: true, header: headers) { (jsonData) in
            let jsonValue = JSON(jsonData)
            var attachmentModels = ACData.ATTACHMENTIMAGEMEDIADATA
            print(jsonValue)
            if(jsonValue["status"] == "success") {
                let attacmentModel = AttachmentImageMediaModel()
                attacmentModel.objectMapping(json: jsonValue)
                attachmentModels.append(attacmentModel)
                successCompletion(attachmentModels)
            } else {
                failCompletion(jsonValue["status"].stringValue)
            }
        }
    }

    
    static func POST_UPLOAD_FILE_EVENT_BANNER_ATTACHMENT_EVENT_MONITORING(
        parameters: Parameters,
        file:UIImage,
        fileName:String,
        fileParameter:String,
        tokenAccess:String,
        successCompletion: @escaping ([AttachmentBannerModel]) -> Void,
        failCompletion: @escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"multipart/form-data; boundary=null",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST_WITH_IMAGE(url: "\(ACUrl.ADMIN_EVENT_MONITORING_UPLOAD_FILE_EVENT)", parameter: parameters, imageFile: file, imageFileName: fileName, imageParameter: fileParameter, showHUD: true, header: headers) { (jsonData) in
            let jsonValue = JSON(jsonData)
            var attachmentModels = ACData.ATTACHMENTBANNERDATA
            print(jsonValue)
            if(jsonValue["status"] == "success") {
                let attacmentModel = AttachmentBannerModel()
                attacmentModel.objectMapping(json: jsonValue)
                attachmentModels.append(attacmentModel)
                successCompletion(attachmentModels)
            } else {
                failCompletion(jsonValue["status"].stringValue)
            }
        }
    }
    
    static func POST_UPLOAD_NEW_IMAGE_MEDIA_ATTACHMENT_ANNOUNCEMENT(
        parameters: Parameters,
        file:UIImage,
        fileName:String,
        fileParameter:String,
        tokenAccess:String,
        successCompletion: @escaping ([AttachmentImageMediaModel]) -> Void,
        failCompletion: @escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"multipart/form-data; boundary=null",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST_WITH_IMAGE(url: "\(ACUrl.POST_UPLOAD_ATTACHMENT_MEDIA_ANNOUNCEMENT)", parameter: parameters, imageFile: file, imageFileName: fileName, imageParameter: fileParameter, showHUD: true, header: headers) { (jsonData) in
            let jsonValue = JSON(jsonData)
            var attachmentModels = ACData.ATTACHMENTIMAGEMEDIADATA
            print(jsonValue)
            if(jsonValue["status"] == "success") {
                let attacmentModel = AttachmentImageMediaModel()
                attacmentModel.objectMapping(json: jsonValue)
                attachmentModels.append(attacmentModel)
                successCompletion(attachmentModels)
            } else {
                failCompletion(jsonValue["status"].stringValue)
            }
        }
    }

    static func POST_UPLOAD_NEW_IMAGE_MEDIA_ATTACHMENT_EVENT_MONITORING(
        parameters: Parameters,
        file:UIImage,
        fileName:String,
        fileParameter:String,
        tokenAccess:String,
        successCompletion: @escaping ([AttachmentImageMediaModel]) -> Void,
        failCompletion: @escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"multipart/form-data; boundary=null",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST_WITH_IMAGE(url: "\(ACUrl.ADMIN_EVENT_MONITORING_ADD_GALLERY)", parameter: parameters, imageFile: file, imageFileName: fileName, imageParameter: fileParameter, showHUD: true, header: headers) { (jsonData) in
            let jsonValue = JSON(jsonData)
            var attachmentModels = ACData.ATTACHMENTIMAGEMEDIADATA
            print(jsonValue)
            if(jsonValue["status"] == "success") {
                let attacmentModel = AttachmentImageMediaModel()
                attacmentModel.objectMapping(json: jsonValue)
                attachmentModels.append(attacmentModel)
                successCompletion(attachmentModels)
            } else {
                failCompletion(jsonValue["status"].stringValue)
            }
        }
    }

    static func POST_UPLOAD_FILE_EVENT_MEDIA_ATTACHMENT_EVENT_MONITORING(
        parameters: Parameters,
        file:UIImage,
        fileName:String,
        fileParameter:String,
        tokenAccess:String,
        successCompletion: @escaping ([AttachmentImageMediaModel]) -> Void,
        failCompletion: @escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"multipart/form-data; boundary=null",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST_WITH_IMAGE(url: "\(ACUrl.ADMIN_EVENT_MONITORING_UPLOAD_FILE_EVENT)", parameter: parameters, imageFile: file, imageFileName: fileName, imageParameter: fileParameter, showHUD: true, header: headers) { (jsonData) in
            let jsonValue = JSON(jsonData)
            var attachmentModels = ACData.ATTACHMENTIMAGEMEDIADATA
            print(jsonValue)
            if(jsonValue["status"] == "success") {
                let attacmentModel = AttachmentImageMediaModel()
                attacmentModel.objectMapping(json: jsonValue)
                attachmentModels.append(attacmentModel)
                successCompletion(attachmentModels)
            } else {
                failCompletion(jsonValue["status"].stringValue)
            }
        }
    }
    
    static func GET_ASSIGNMENT_STUDENT_NOTE(
        childID:String,
        chapterID:String,
        successCompletion:@escaping (StudentNoteModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_ANNOUNCEMENT_DETAIL)announcement_id=\(announcementID)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_ASSIGNMENT_STUDENT_NOTE)child_id=\(childID)&chapter_id=\(chapterID)", header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if json["status"] == "success" {
                let detail = StudentNoteModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_ANNOUNCEMENT_DETAIL(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        announcementID:String,
        accessToken:String,
        successCompletion:@escaping (AnnouncementDetail) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "announcement_id":announcementID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(accessToken)"]
        ACAPI.POST(url: ACUrl.PARENT_GET_ANNOUNCEMENT_DETAIL, parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if json["status"] == "success" {
                let detail = AnnouncementDetail()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_ANNOUNCEMENT_DETAIL_FOR_EDIT(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        announcementID:String,
        accessToken:String,
        successCompletion:@escaping (AnnouncementEditDetail) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "announcement_id":announcementID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(accessToken)"]
        ACAPI.POST(url: ACUrl.POST_GET_ANNOUNCEMENT_DETAIL_FOR_EDIT, parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if json["status"] == "success" {
                let detail = AnnouncementEditDetail()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_SUBJECT_DETAIL(
        subjectID:String,
        childID:String,
        successCompletion:@escaping (SubjectDetailModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_SUBJECT_DETAIL)subject_id=\(subjectID)&child_id=\(childID)", header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if json["status"] == "success" {
                let detail = SubjectDetailModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_SUBJECT_LIST_PERFORMANCE(
        childID: String,
        successCompletion: @escaping ([SubjectListModel]) -> Void,
        failCompletion: @escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_ASSIGNMENT)child_id=\(childID)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_SUBJECT)child_id=\(childID)", header: headers, showHUD: true) { (jsonData) in
            var subjectModels = ACData.SUBJECTLISTDATA
            
            let json = JSON(jsonData)
            print(json)
            
            if(json["status"] == "success"){
                if let data = json["subjects"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let subjectModel = SubjectListModel()
                            subjectModel.objectMapping(json: jsonValue)
                            subjectModels.append(subjectModel)
                        }
                    } else {
                        failCompletion("Have no subject")
                    }
                }
                successCompletion(subjectModels)
            }else{
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func POST_REGIST_SCHOOL(
        parentName:String,
        parentPhone:String,
        childName:String,
        schoolName:String,
        schoolClass:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
        let parameters: Parameters = [
            "parent_name":parentName,
            "parent_phone":parentPhone,
            "child_name":childName,
            "school_name":schoolName,
            "school_class":schoolClass
        ]
        print(parameters)
        ACAPI.POST(url: "\(ACUrl.PARENT_POST_SCHOOL_REGISTER)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if json["status"] == "success" {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    
    
    static func POST_PARENT_UPDATE_APPROVAL(
        eventID:String,
        isApproved:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
        let parameters: Parameters = [
            "event_id":eventID,
            "is_approved":isApproved
        ]
        print(parameters)
        ACAPI.POST(url: "\(ACUrl.PARENT_UPDATE_APPROVAL)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if json["status"] == "success" {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func GET_EVENT_APPROVAL_DETAIL(
        eventID:String,
        childID:String,
        successCompletion:@escaping (ApprovalDetailModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        print("url: \(ACUrl.PARENT_GET_EVENT_APPROVAL_DETAIL)event_id=\(eventID)&child_id=\(childID)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_EVENT_APPROVAL_DETAIL)event_id=\(eventID)&child_id=\(childID)", header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print("json approval detail: \(json)")
            if json["status"] == "success" {
                let detail = ApprovalDetailModel()
                detail.objectMapping(json: json)
                successCompletion(detail)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_ASSIGNMENT_DATA(
        childID: String,
        successCompletion: @escaping ([AssignmentModulModel]) -> Void,
        failCompletion: @escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_ASSIGNMENT)child_id=\(childID)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_ASSIGNMENT)child_id=\(childID)", header: headers, showHUD: true) { (jsonData) in
            var assignmentModels = ACData.ASSIGNMENTMODULMODEL
            
            let json = JSON(jsonData)
            print(json)
            
            if(json["status"] == "success"){
                if let data = json["assignment"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let assignmentModel = AssignmentModulModel()
                            assignmentModel.objectMapping(json: jsonValue)
                            assignmentModels.append(assignmentModel)
                        }
                    } else {
                        failCompletion("Have no assignment")
                    }
                }
                successCompletion(assignmentModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_ASSIGNMENT_DETAIL(
        schoolAssignmentId: String,
        childID:String,
        successCompletion: @escaping (AssignmentDetailModel) -> Void,
        failCompletion: @escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        print("url: \(ACUrl.GET_ASSIGNMENT_DETAIL)school_assignment_id=\(schoolAssignmentId)&child_id=\(childID)")
        ACAPI.GET(url: "\(ACUrl.GET_ASSIGNMENT_DETAIL)school_assignment_id=\(schoolAssignmentId)&child_id=\(childID)", header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print("assignment detail:\(json)")
            if(json["status"] == "success"){
                let assignmentDetail = AssignmentDetailModel()
                assignmentDetail.objectMapping(json: json)
                successCompletion(assignmentDetail)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_APPROVAL_DATA(
        childID:String,
        successCompletion:@escaping ([ApprovalModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        print("url: \(ACUrl.PARENT_GET_APPROVAL)child_id=\(childID)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_APPROVAL)child_id=\(childID)", header: headers, showHUD: true) { (jsonData) in
            var approvalModels = ACData.APPROVAL
            let json = JSON(jsonData)
            print("json approval: \(json)")
            if(json["status"] == "success") {
                if let data = json["event_approval"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let approvalModel = ApprovalModel()
                            approvalModel.objectMapping(json: jsonValue)
                            approvalModels.append(approvalModel)
                        }
                    } else {
                        failCompletion("Have no approval")
                    }
                }
                successCompletion(approvalModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_AGENCY_DATA(
        successCompletion:@escaping ([AgencyModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_AGENCY)")
        //print("asdasd")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_AGENCY)", header: headers, showHUD: true) { (jsonData) in
            var agencyModels = ACData.AGENCY
            
            let json = JSON(jsonData)
            //print(json)
            
            if(json["status"] == "success"){
                if let data = json["Agency"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let agencyModel = AgencyModel()
                            agencyModel.objectMapping(json: jsonValue)
                            agencyModels.append(agencyModel)
                        }
                    } else {
                        failCompletion("Have no agency")
                    }
                }
                successCompletion(agencyModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_SCORE(
        childID:String,
        successCompletion:@escaping ([ScoreModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        print("url: \(ACUrl.PARENT_GET_SCORE)child_id=\(childID)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_SCORE)child_id=\(childID)", header: headers, showHUD: true) { (jsonData) in
            var scoreModels = ACData.SCOREDATA
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                if let data = json["subjects"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let scoreModel = ScoreModel()
                            scoreModel.objectMapping(json: jsonValue)
                            scoreModels.append(scoreModel)
                        }
                    } else {
                        failCompletion("Have no score")
                    }
                }
                successCompletion(scoreModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_SCORE_SUMMARY(
        childID:String,
        successCompletion:@escaping ([ScoreSummaryModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        print("url: \(ACUrl.PARENT_GET_SCORE_SUMMARY)child_id=\(childID)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_SCORE_SUMMARY)child_id=\(childID)", header: headers, showHUD: true) { (jsonData) in
            var scoreModels = ACData.SCORESUMMARYDATA
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                if let data = json["subjects"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let scoreModel = ScoreSummaryModel()
                            scoreModel.objectMapping(json: jsonValue)
                            scoreModels.append(scoreModel)
                        }
                    } else {
                        failCompletion("Have no summary score")
                    }
                }
                successCompletion(scoreModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func POST_DELETE_SCORE(
        subjectID:String,
        scoreTypeID:String,
        childID:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        let parameters: Parameters = [
            "subject_id":subjectID,
            "score_type_id":scoreTypeID,
            "child_id":childID
        ]
        ACAPI.POST(url: "\(ACUrl.PARENT_DELETE_SCORE)", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            if json["status"] == "success" {
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func GET_MEDICAL_DATA(
        childID:String,
        successCompletion:@escaping ([MedicalModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_MEDICAL_RECORD)child_id=\(childID)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_MEDICAL_RECORD)child_id=\(childID)", header: headers, showHUD: true) { (jsonData) in
            var medicalModels = ACData.MEDICAL
            
            let json = JSON(jsonData)
            //print(json)
            
            if(json["status"] == "success") {
                if let data = json["medical"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let medicalModel = MedicalModel()
                            medicalModel.objectMapping(json: jsonValue)
                            medicalModels.append(medicalModel)
                        }
                    } else {
                        failCompletion("Have no approval")
                    }
                }
                successCompletion(medicalModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_PERMISSION_DATA(
        childID:String,
        successCompletion:@escaping (PermissionModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_PERMISSION)child_id=\(childID)", header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print("json permission data: \(json)")
            if(json["status"] == "success") {
                let permission = PermissionModel()
                permission.objectMapping(json: json)
                successCompletion(permission)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_COMPETITION_CATEGORY(
        successCompletion:@escaping ([CompetitionCategoryModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_COMPETITION_CATEGORY)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_COMPETITION_CATEGORY)", header: headers, showHUD: true) { (jsonData) in
            
            var competitionCategoryModels = ACData.COMPETITIONCATEGORYDATA
            
            let json = JSON(jsonData)
            //print(json)
            
            if(json["status"] == "success") {
                if let data = json["competitionCategory"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let competitionModel = CompetitionCategoryModel()
                            competitionModel.objectMapping(json: jsonValue)
                            competitionCategoryModels.append(competitionModel)
                        }
                    } else {
                        failCompletion("Have no competition category")
                    }
                }
                successCompletion(competitionCategoryModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_COMPETITION_DATA(
        competitionCategoryID:String,
        successCompletion:@escaping ([CompetitionModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_COMPETITION)competition_category_id=\(competitionCategoryID)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_COMPETITION)competition_category_id=\(competitionCategoryID)", header: headers, showHUD: true) { (jsonData) in
            
            var competitionModels = ACData.COMPETITIONDATA
            
            let json = JSON(jsonData)
            //print(json)
            
            if(json["status"] == "success") {
                if let data = json["competition"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let competitionModel = CompetitionModel()
                            competitionModel.objectMapping(json: jsonValue)
                            competitionModels.append(competitionModel)
                        }
                    } else {
                        failCompletion("Have no approval")
                    }
                }
                successCompletion(competitionModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_NEARBY_DATA(
        successCompletion:@escaping ([NearbyModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_NEARBY_COURSE)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_NEARBY_COURSE)", header: headers, showHUD: true) { (jsonData) in
            
            var nearbyModels = ACData.NEARBYDATA
            
            let json = JSON(jsonData)
            //print(json)
            
            if(json["status"] == "success") {
                if let data = json["course_categories"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let nearbyModel = NearbyModel()
                            nearbyModel.objectMapping(json: jsonValue)
                            nearbyModels.append(nearbyModel)
                        }
                    } else {
                        failCompletion("Have no nearby course")
                    }
                }
                successCompletion(nearbyModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_NEWS_DATA(
        roleID:String,
        successCompletion:@escaping ([ParentNewsModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_NEWS)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_NEWS)role_id=\(roleID)", header: headers, showHUD: true) { (jsonData) in
            
            var newsModels = ACData.PARENTNEWSCONTENT
            
            let json = JSON(jsonData)
            //print(json)
            
            if(json["status"] == "success") {
                if let data = json["news"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let newsModel = ParentNewsModel()
                            newsModel.objectMapping(json: jsonValue)
                            newsModels.append(newsModel)
                        }
                    } else {
                        failCompletion("Have no news")
                    }
                }
                successCompletion(newsModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_NEARBY_MORE(
        courseCategoryId:Int,
        successCompletion:@escaping ([NearbyCourseMoreModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        print("url: \(ACUrl.PARENT_GET_NEARBY_COURSE_MORE)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_NEARBY_COURSE_MORE)course_category_id=\(courseCategoryId)", header: headers, showHUD: true) { (jsonData) in
            var nearbyCourseMoreModels = ACData.NEARBYCOURSEMOREDATA
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                if let data = json["course"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let nearbyMoreModel = NearbyCourseMoreModel()
                            nearbyMoreModel.objectMapping(json: jsonValue)
                            nearbyCourseMoreModels.append(nearbyMoreModel)
                        }
                    } else {
                        failCompletion("Have no nearby more data")
                    }
                }
                successCompletion(nearbyCourseMoreModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_CALENDAR_DATA(
        childID:String,
        eventDate:String,
        successCompletion:@escaping (CalendarModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        print("url: \(ACUrl.PARENT_GET_CALENDAR_EVENTS)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_CALENDAR_EVENTS)child_id=\(childID)&event_date=\(eventDate)", header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                let calendar = CalendarModel()
                calendar.objectMapping(json: json)
                successCompletion(calendar)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_CALENDAR_AGENDA_LIST(
        childID:String,
        successCompletion:@escaping ([CalendarAgendaModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        print("url: \(ACUrl.PARENT_GET_CALENDAR_AGENDA_LIST)child_id=\(childID)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_CALENDAR_AGENDA_LIST)child_id=\(childID)", header: headers, showHUD: true) { (jsonData) in
            var calendarAgendaModels = ACData.CALENDARAGENDALISTDATA
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                if let data = json["agendas"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let calendarAgendaModel = CalendarAgendaModel()
                            calendarAgendaModel.objectMapping(json: jsonValue)
                            calendarAgendaModels.append(calendarAgendaModel)
                        }
                    } else {
                        failCompletion("Have no agenda data")
                    }
                }
                successCompletion(calendarAgendaModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_FUTURE_PLAN_ACADEMY(
        successCompletion:@escaping ([FuturePlanAcademyModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_FUTURE_PLAN_ACADEMYC)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_FUTURE_PLAN_ACADEMYC)", header: headers, showHUD: true) { (jsonData) in
            
            var futureAcademyModels = ACData.FUTUREPLANACADEMYDATA
            
            let json = JSON(jsonData)
            //print(json)
            
            if(json["status"] == "success") {
                if let data = json["Academic"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let futureAcademyModel = FuturePlanAcademyModel()
                            futureAcademyModel.objectMapping(json: jsonValue)
                            futureAcademyModels.append(futureAcademyModel)
                        }
                    } else {
                        failCompletion("Have no future plan in academy data")
                    }
                }
                successCompletion(futureAcademyModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_FUTURE_PLAN_TALENT(
        successCompletion:@escaping ([FuturePlanTalentModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_FUTURE_PLAN_TALENT)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_FUTURE_PLAN_TALENT)", header: headers, showHUD: true) { (jsonData) in
            
            var futureTalentModels = ACData.FUTUREPLANTALENTDATA
            
            let json = JSON(jsonData)
            //print(json)
            
            if(json["status"] == "success") {
                if let data = json["Talent"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let futureTalentModel = FuturePlanTalentModel()
                            futureTalentModel.objectMapping(json: jsonValue)
                            futureTalentModels.append(futureTalentModel)
                        }
                    } else {
                        failCompletion("Have no future plan in talent data")
                    }
                }
                successCompletion(futureTalentModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_FUTURE_PLAN_CAREER(
        successCompletion:@escaping ([FuturePlanCareerModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_FUTURE_PLAN_CAREER)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_FUTURE_PLAN_CAREER)", header: headers, showHUD: true) { (jsonData) in
            
            var futureCareerModels = ACData.FUTUREPLANCAREERDATA
            
            let json = JSON(jsonData)
            //print(json)
            
            if(json["status"] == "success") {
                if let data = json["career"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let futureCareerModel = FuturePlanCareerModel()
                            futureCareerModel.objectMapping(json: jsonValue)
                            futureCareerModels.append(futureCareerModel)
                        }
                    } else {
                        failCompletion("Have no future plan in career data")
                    }
                }
                successCompletion(futureCareerModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_CAREER_BY_ACADEMY(
        academicID:String,
        successCompletion:@escaping ([FuturePlanCareerModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_FUTURE_PLAN_CAREER_BY_ACADEMYC)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_FUTURE_PLAN_CAREER_BY_ACADEMYC)academic_id=\(academicID)", header: headers, showHUD: true) { (jsonData) in
            
            var futureCareerModels = ACData.FUTUREPLANCAREERDATA
            
            let json = JSON(jsonData)
            //print(json)
            
            if(json["status"] == "success") {
                if let data = json["career"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let futureCareerModel = FuturePlanCareerModel()
                            futureCareerModel.objectMapping(json: jsonValue)
                            futureCareerModels.append(futureCareerModel)
                        }
                    } else {
                        failCompletion("Have no future plan in career data")
                    }
                }
                successCompletion(futureCareerModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_CAREER_BY_TALENT(
        talentID:String,
        successCompletion:@escaping ([FuturePlanCareerModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_FUTURE_PLAN_CAREER_BY_TALENT)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_FUTURE_PLAN_CAREER_BY_TALENT)talent_id=\(talentID)", header: headers, showHUD: true) { (jsonData) in
            
            var futureCareerModels = ACData.FUTUREPLANCAREERDATA
            
            let json = JSON(jsonData)
            //print(json)
            
            if(json["status"] == "success") {
                if let data = json["career"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let futureCareerModel = FuturePlanCareerModel()
                            futureCareerModel.objectMapping(json: jsonValue)
                            futureCareerModels.append(futureCareerModel)
                        }
                    } else {
                        failCompletion("Have no future plan in career data")
                    }
                }
                successCompletion(futureCareerModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_CAREER_DETAIL(
        careerID:String,
        successCompletion:@escaping (CareerDetailModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_FUTURE_PLAN_CAREER_DETAIL)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_FUTURE_PLAN_CAREER_DETAIL)career_id=\(careerID)", header: headers, showHUD: true) { (jsonData) in
            
            let json = JSON(jsonData)
            //print(json)
            
            if(json["status"] == "success") {
                let careerDetail = CareerDetailModel()
                careerDetail.objectMapping(json: json)
                successCompletion(careerDetail)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_UNIVERSITY_BY_MAJOR(
        majorID:String,
        successCompletion:@escaping ([UniversityModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_FUTURE_PLAN_MAJOR_UNIVERSITY)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_FUTURE_PLAN_MAJOR_UNIVERSITY)major_id=\(majorID)", header: headers, showHUD: true) { (jsonData) in
            
            var universityModels = ACData.UNIVERSITYDATA
            
            let json = JSON(jsonData)
            //print(json)
            
            if(json["status"] == "success") {
                if let data = json["university"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let universityModel = UniversityModel()
                            universityModel.objectMapping(json: jsonValue)
                            universityModels.append(universityModel)
                        }
                    } else {
                        failCompletion("Have no university on selected")
                    }
                }
                successCompletion(universityModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_UNIVERSITY_DETAIL(
        universityID:String,
        successCompletion:@escaping (UniversityDetailModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_FUTURE_PLAN_UNIVERSITY_DETAIL)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_FUTURE_PLAN_UNIVERSITY_DETAIL)university_id=\(universityID)", header: headers, showHUD: true) { (jsonData) in
            
            let json = JSON(jsonData)
            //print(json)
            
            if(json["status"] == "success") {
                let universityDetail = UniversityDetailModel()
                universityDetail.objectMapping(json: json)
                successCompletion(universityDetail)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_COMPETITION_DETAIL(
        competitionID:String,
        successCompletion:@escaping (CompetitionDetailModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_COMPETITION_DETAIL)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_COMPETITION_DETAIL)competition_id=\(competitionID)", header: headers, showHUD: true) { (jsonData) in
            
            let json = JSON(jsonData)
            //print(json)
            
            if(json["status"] == "success") {
                let competitionDetail = CompetitionDetailModel()
                competitionDetail.objectMapping(json: json)
                successCompletion(competitionDetail)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_COURSE_DETAIL(
        courseID:String,
        successCompletion:@escaping (CourseDetailModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_NEARBY_COURSE_DETAIL)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_NEARBY_COURSE_DETAIL)course_id=\(courseID)", header: headers, showHUD: true) { (jsonData) in
            
            let json = JSON(jsonData)
            //print(json)
            
            if(json["status"] == "success") {
                let courseDetail = CourseDetailModel()
                courseDetail.objectMapping(json: json)
                successCompletion(courseDetail)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_ATTENDANCE_DATA(
        childID:String,
        successCompletion:@escaping (AttendanceModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_ATTENDANCE)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_ATTENDANCE)child_id=\(childID)", header: headers, showHUD: true) { (jsonData) in
            
            let json = JSON(jsonData)
            print("attendance list: \(json)")
            
            if(json["status"] == "success") {
                let attendanceData = AttendanceModel()
                attendanceData.objectMapping(json: json)
                successCompletion(attendanceData)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_LOGIN_INFO_DATA(
        successCompletion:@escaping ([SchoolModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        print("url: \(ACUrl.PARENT_GET_LOGIN_INFO)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_LOGIN_INFO)", header: headers, showHUD: true) { (jsonData) in
            var schoolModels = ACData.SCHOOLDATA
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                if let data = json["school"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let schoolModel = SchoolModel()
                            schoolModel.objectMapping(json: jsonValue)
                            schoolModels.append(schoolModel)
                        }
                    } else {
                        failCompletion("Have no school")
                    }
                }
                successCompletion(schoolModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func POST_FORGOT_CHECK_PHONE(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        phone:String,
        tokenAccess:String,
        successCompletion:@escaping (Bool) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters: Parameters = [
            "phone":phone
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        ACAPI.POST(url: ACUrl.PARENT_CHECK_PHONE, parameter: parameters, header: headers, showHUD: true, completion: {jsonData in
            let json = JSON(jsonData)
            print(json)
            if json["status"] == "success" {
                successCompletion(json["is_registered"].boolValue)
            } else {
                failCompletion("Phone is not registered")
            }
        })
    }

    static func POST_FORGOT_SET_NEW(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        newPass:String,
        phone:String,
        tokenAccess:String,
        successCompletion:@escaping (Bool) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "new_password":newPass,
            "phone":phone
        ]
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: ACUrl.PARENT_SET_NEW_PASSWORD, parameter: parameters, header: headers, showHUD: true, completion: {jsonData in
            let json = JSON(jsonData)
            print(json)
            if json["status"] == "success" {
                successCompletion(json["is_success"].boolValue)
            } else {
                failCompletion("Something went wrong, please try again.")
            }
        })
    }
    
    static func POST_DELETE_SUBJECT_EDIT_PROFILE(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        schoolSubjectTeacherID:String,
        tokenAccess:String,
        successCompletion:@escaping (Bool) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "school_subject_teacher_id":schoolSubjectTeacherID
        ]
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: ACUrl.EDIT_PROFILE_DELETE_SUBJECT_CLASS, parameter: parameters, header: headers, showHUD: true, completion: {jsonData in
            let json = JSON(jsonData)
            print(json)
            if json["status"] == "success" {
                successCompletion(json["is_success"].boolValue)
            } else {
                failCompletion("Something went wrong, please try again.")
            }
        })
    }
    
    static func POST_ADD_NEW_SUBJECT_EDIT_PROFILE(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        subjectID:String,
        schoolClassID:String,
        tokenAccess:String,
        successCompletion:@escaping (Bool) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "subject_id":subjectID,
            "school_class_id":schoolClassID
        ]
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: ACUrl.ADD_NEW_SUBJECT_IN_EDIT_PROFILE, parameter: parameters, header: headers, showHUD: true, completion: {jsonData in
            let json = JSON(jsonData)
            print("add new return: \(json)")
            if json["status"] == "success" {
                successCompletion(json["is_success"].boolValue)
            } else {
                failCompletion("Something went wrong, please try again.")
            }
        })
    }
    
    static func POST_SAVE_NEW_PROFILE(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        teacherAddress:String,
        teacherPhone:String,
        teacherEmail:String,
        position:String,
        teacherImage:String,
        tokenAccess:String,
        successCompletion:@escaping (Bool) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "teacher_address":teacherAddress,
            "teacher_phone":teacherPhone,
            "teacher_email":teacherEmail,
            "position":position,
            "teacher_image":teacherImage
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: ACUrl.SAVE_UPDATED_PROFILE, parameter: parameters, header: headers, showHUD: true, completion: {jsonData in
            let json = JSON(jsonData)
            print("add new return: \(json)")
            if json["status"] == "success" {
                successCompletion(json["is_success"].boolValue)
            } else {
                failCompletion("Something went wrong, please try again.")
            }
        })
    }
    
    static func POST_SEE_MORE_UPCOMING_SESSION(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        page:Int,
        tokenAccess:String,
        successCompletion:@escaping ([UpcomingSessionListModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "page":page
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: ACUrl.SEE_MORE_UPCOMING_SESSION, parameter: parameters, header: headers, showHUD: true, completion: {jsonData in
            var upcomingSessions = ACData.UPCOMINGSESSIONLISTDATA
            let json = JSON(jsonData)
            print("upcoming session json: \(json)")
            if(json["status"] == "success"){
                if let data = json["data"]["current_session_list"]["data"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let upcomingSession = UpcomingSessionListModel()
                            upcomingSession.objectMapping(json: jsonValue)
                            upcomingSessions.append(upcomingSession)
                        }
                    } else {
                        failCompletion("Have no session")
                    }
                }
                successCompletion(upcomingSessions)
            } else {
                failCompletion(json["message"].stringValue)
            }
        })
    }
    
    static func POST_ADMIN_GET_MORE_EVENT(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        tokenAccess:String,
        successCompletion:@escaping ([AdminEventListModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: ACUrl.ADMIN_GET_MORE_EVENTS, parameter: parameters, header: headers, showHUD: true, completion: {jsonData in
            var eventLists = ACData.ADMINEVENTLISTDATA
            let json = JSON(jsonData)
            print("event list json: \(json)")
            if(json["status"] == "success"){
                if let data = json["data"]["list_event"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let eventList = AdminEventListModel()
                            eventList.objectMapping(json: jsonValue)
                            eventLists.append(eventList)
                        }
                    } else {
                        failCompletion("Have no event")
                    }
                }
                successCompletion(eventLists)
            } else {
                failCompletion(json["message"].stringValue)
            }
        })
    }
    
    static func POST_CURRENT_SESSION_MORE(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        page:Int,
        tokenAccess:String,
        successCompletion:@escaping (CurrentClassListModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "page":page
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: ACUrl.POST_CURRENT_CLASS_MORE, parameter: parameters, header: headers, showHUD: true, completion: {jsonData in
            let json = JSON(jsonData)
            print("event list json: \(json)")
            if(json["status"] == "success"){
                let currentClassData = CurrentClassListModel()
                currentClassData.objectMapping(json: json)
                successCompletion(currentClassData)
            } else {
                failCompletion(json["message"].stringValue)
            }
        })
    }
    
    static func POST_SEE_SUBJECT_TEACHER_BY_CLASS(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        tokenAccess:String,
        successCompletion:@escaping ([SubjectTopicByClassModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: ACUrl.GET_SUBJECT_TEACHER_BY_CLASS, parameter: parameters, header: headers, showHUD: true, completion: {jsonData in
            var classModels = ACData.SUBJECTTEACHERBYCLASS
            let json = JSON(jsonData)
            print("json: \(json)")
            if(json["status"] == "success"){
                if let data = json["data"]["by_class"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let classModel = SubjectTopicByClassModel()
                            classModel.objectMapping(json: jsonValue)
                            classModels.append(classModel)
                        }
                    } else {
                        failCompletion("Have no data")
                    }
                }
                successCompletion(classModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        })
    }
    
    static func POST_SEE_SUBJECT_TEACHER_SESSION_LIST(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        schoolClassID:String,
        subjectID:String,
        tokenAccess:String,
        successCompletion:@escaping (SubjectTeacherByClassSessionListModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "school_class_id":schoolClassID,
            "subject_id":subjectID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: ACUrl.GET_SUBJECT_TEACHER_SESSION_LIST, parameter: parameters, header: headers, showHUD: true, completion: {jsonData in
            let json = JSON(jsonData)
            print("school detail: \(json)")
            if(json["status"] == "success") {
                let schoolDetail = SubjectTeacherByClassSessionListModel()
                schoolDetail.objectMapping(json: json)
                successCompletion(schoolDetail)
            } else {
                failCompletion(json["message"].stringValue)
            }
        })
    }
    
    static func POST_UPDATE_SUBJECT_TEACHER_SESSION_LIST(
        params:Parameters,
        tokenAccess:String,
        successCompletion:@escaping (String) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: "\(ACUrl.SAVE_SUBJECT_TEACHER_SESSION_LIST)", parameter: params, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success"){
                successCompletion(json["status"].stringValue)
            } else {
                failCompletion(json["status"].stringValue)
            }
        }
    }
    
    static func POST_SEE_SUBJECT_TEACHER_CHAPTER_LIST(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        schoolLevelID:String,
        subjectID:String,
        tokenAccess:String,
        successCompletion:@escaping (SubjectTeacherChapterListModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "school_level_id":schoolLevelID,
            "subject_id":subjectID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: ACUrl.GET_SUBJECT_TEACHER_CHAPTER_LIST, parameter: parameters, header: headers, showHUD: true, completion: {jsonData in
//            var chapterModels = ACData.SUBJECTTEACHERCHAPTERLISTDATA
            let json = JSON(jsonData)
            print("json: \(json)")
            if(json["status"] == "success"){
                let schoolDetail = SubjectTeacherChapterListModel()
                schoolDetail.objectMapping(json: json)
                successCompletion(schoolDetail)
//                if let data = json["data"]["chapter"]["topic_list"].array {
//                    if data.count > 0 {
//                        for jsonValue in data {
//                            let chapterModel = SubjectTeacherChapterListModel()
//                            chapterModel.objectMapping(json: jsonValue)
//                            chapterModels.append(chapterModel)
//                        }
//                    } else {
//                        failCompletion("Have no data")
//                    }
//                }
//                successCompletion(chapterModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        })
    }
    
    static func POST_GET_PARAM_FOR_ADD_SUBJECT_TEACHER(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        schoolLevelID:String,
        subjectID:String,
        schoolGradeID:String,
        schoolMajorID:String,
        tokenAccess:String,
        successCompletion:@escaping (SubjectTeacherParamModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID,
            "school_level_id":schoolLevelID,
            "subject_id":subjectID,
            "school_grade_id":schoolGradeID,
            "school_major_id":schoolMajorID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: ACUrl.GET_PARAM_FOR_ADD_SUBJECT_TOPIC, parameter: parameters, header: headers, showHUD: true, completion: {jsonData in
            let json = JSON(jsonData)
            print("json: \(json)")
            if(json["status"] == "success"){
                let schoolDetail = SubjectTeacherParamModel()
                schoolDetail.objectMapping(json: json)
                successCompletion(schoolDetail)
            } else {
                failCompletion(json["message"].stringValue)
            }
        })
    }
    
    static func POST_SEE_SUBJECT_TEACHER_BY_SUBJECT(
        userID:String,
        role:String,
        schoolID:String,
        yearID:String,
        tokenAccess:String,
        successCompletion:@escaping ([SubjectTopicBySubjectModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let parameters:Parameters = [
            "user_id":userID,
            "role":role,
            "school_id":schoolID,
            "year_id":yearID
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json",
                                   "Authorization":"Bearer \(tokenAccess)"]
        ACAPI.POST(url: ACUrl.GET_SUBJECT_TEACHER_BY_SUBJET, parameter: parameters, header: headers, showHUD: true, completion: {jsonData in
            var subjectModels = ACData.SUBJECTTEACHERBYSUBJECT
            let json = JSON(jsonData)
            print("json: \(json)")
            if(json["status"] == "success"){
                if let data = json["data"]["by_subject"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let subjectModel = SubjectTopicBySubjectModel()
                            subjectModel.objectMapping(json: jsonValue)
                            subjectModels.append(subjectModel)
                        }
                    } else {
                        failCompletion("Have no data")
                    }
                }
                successCompletion(subjectModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        })
    }

    static func GET_SCHOOL_DETAIL(
        schoolID:String,
        successCompletion:@escaping (SchoolDetailModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        //print("url: \(ACUrl.PARENT_GET_FUTURE_PLAN_UNIVERSITY_DETAIL)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_SCHOOL_DETAIL)school_id=\(schoolID)", header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print("school detail: \(json)")
            if(json["status"] == "success") {
                let schoolDetail = SchoolDetailModel()
                schoolDetail.objectMapping(json: json)
                successCompletion(schoolDetail)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_NOTIFICATION_DATA(
        parentID:String,
        successCompletion:@escaping ([NotificationModel]) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        print("url: \(ACUrl.PARENT_GET_NOTIFICATION_LIST)")
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_NOTIFICATION_LIST)parent_id=\(parentID)", header: headers, showHUD: true) { (jsonData) in
            var notificationModels = ACData.NOTIFICATIONDATA
            let json = JSON(jsonData)
            print("notification json: \(json)")
            if(json["status"] == "success"){
                if let data = json["notifications"].array {
                    if data.count > 0 {
                        for jsonValue in data {
                            let notificationModel = NotificationModel()
                            notificationModel.objectMapping(json: jsonValue)
                            notificationModels.append(notificationModel)
                        }
                    } else {
                        failCompletion("Have no notification")
                    }
                }
                successCompletion(notificationModels)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_PARENT_PROFILE_DATA(
        parentID:String,
        successCompletion:@escaping (ParentProfileModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        ACAPI.GET(url: "\(ACUrl.PARENT_PROFILE)parent_id=\(parentID)", header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            if(json["status"] == "success") {
                let parentData = ParentProfileModel()
                parentData.objectMapping(json: json)
                successCompletion(parentData)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
    
    static func GET_SUBJECT_SEARCH(
        keyword:String,
        childID:String,
        subjectID:String,
        successCompletion:@escaping (SearchModel) -> Void,
        failCompletion:@escaping (String) -> Void) {
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        ACAPI.GET(url: "\(ACUrl.PARENT_GET_SEARCH_SUBJECT)keyword=\(keyword)&child_id=\(childID)&subject_id=\(subjectID)", header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print(json)
            if(json["status"] == "success") {
                let searchData = SearchModel()
                searchData.objectMapping(json: json)
                successCompletion(searchData)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
}
