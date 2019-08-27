//
//  SubjectDetailModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 11/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class SubjectDetailModel: NSObject {
    var teacher_info_subject_name = ""
    var teacher_info_teacher_name = ""
    var score_subject_grade_id = ""
    var score_subject_id = ""
    var score_school_grade_id = ""
    var score_school_level_id = ""
    var score_passing_grade = ""
    var score_radian = ""
    var score_averagescore = ""
    var score_color = ""
    var upcoming_sessions = [SubjectDetailUpcomingSessionModel]()
    var upcoming_assignments = [SubjectDetailUpcomingAssignment]()
    var questions = [SubjectDetailQuestionsModel]()
    var score_perfomances = [SubjectDetailScorePerformanceModel]()
    
    func objectMapping(json: JSON) {
        teacher_info_subject_name = json["subject_detail"]["teacher_info"]["subject_name"].stringValue
        teacher_info_teacher_name = json["subject_detail"]["teacher_info"]["teacher_name"].stringValue
        score_subject_grade_id = json["subject_detail"]["score"]["subject_grade_id"].stringValue
        score_subject_id = json["subject_detail"]["score"]["subject_id"].stringValue
        score_school_grade_id = json["subject_detail"]["score"]["school_grade_id"].stringValue
        score_school_level_id = json["subject_detail"]["score"]["school_level_id"].stringValue
        score_passing_grade = json["subject_detail"]["score"]["passing_grade"].stringValue
        score_radian = json["subject_detail"]["score"]["radian"].stringValue
        score_averagescore = json["subject_detail"]["score"]["averagescore"].stringValue
        score_color = json["subject_detail"]["score"]["color"].stringValue
        
        for data in json["subject_detail"]["upcoming_sessions"].arrayValue {
            let d = SubjectDetailUpcomingSessionModel()
            d.objectMapping(json: data)
            upcoming_sessions.append(d)
        }
        for data in json["subject_detail"]["upcoming_assignments"].arrayValue {
            let d = SubjectDetailUpcomingAssignment()
            d.objectMapping(json: data)
            upcoming_assignments.append(d)
        }
        for data in json["subject_detail"]["questions"].arrayValue {
            let d = SubjectDetailQuestionsModel()
            d.objectMapping(json: data)
            questions.append(d)
        }
        for data in json["subject_detail"]["score"]["perfomances"].arrayValue {
            let d = SubjectDetailScorePerformanceModel()
            d.objectMapping(json: data)
            score_perfomances.append(d)
        }
    }
}

class SubjectDetailUpcomingSessionModel: NSObject {
    var chapter_id = ""
    var subject_grade_id = ""
    var chapter_name = ""
    var chapter_desc = ""
    var subject_id = ""
    var subject_name = ""
    
    func objectMapping(json: JSON) {
        chapter_id = json["chapter_id"].stringValue
        subject_grade_id = json["subject_grade_id"].stringValue
        chapter_name = json["chapter_name"].stringValue
        chapter_desc = json["chapter_desc"].stringValue
        subject_id = json["subject_id"].stringValue
        subject_name = json["subject_name"].stringValue
    }
}

class SubjectDetailUpcomingAssignment: NSObject {
    var school_assignment_id = ""
    var assignment_due_date = ""
    var subject_session = ""
    var subject_name = ""
    var assignment_status = ""

    func objectMapping(json: JSON) {
        school_assignment_id = json["school_assignment_id"].stringValue
        assignment_due_date = json["assignment_due_date"].stringValue
        subject_session = json["subject_session"].stringValue
        subject_name = json["subject_name"].stringValue
        assignment_status = json["assignment_status"].stringValue
    }
}

class SubjectDetailQuestionsModel: NSObject {
    var question_id = ""
    var child_id = ""
    var subject_id = ""
    var question_topic = ""
    var question = ""
    var teacher_id = ""
    var status = ""
    var subject_name = ""
    
    func objectMapping(json: JSON) {
        question_id = json["question_id"].stringValue
        child_id = json["child_id"].stringValue
        subject_id = json["subject_id"].stringValue
        question_topic = json["question_topic"].stringValue
        question = json["question"].stringValue
        teacher_id = json["teacher_id"].stringValue
        status = json["status"].stringValue
        subject_name = json["subject_name"].stringValue
    }
}

class SubjectDetailScorePerformanceModel: NSObject {
    var month = ""
    var score = ""
    
    func objectMapping(json: JSON) {
        month = json["month"].stringValue
        score = json["score"].stringValue
    }
}
