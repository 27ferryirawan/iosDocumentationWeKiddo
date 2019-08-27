//
//  SearchModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 12/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchModel: NSObject {
    var upcoming_sessions = [SubjectSearchUpcomingSessionModel]()
    var upcoming_assignments = [SubjectSearchUpcomingAssignment]()
    var questions = [SubjectSearchQuestionsModel]()
    
    func objectMapping(json: JSON) {
        for data in json["subject_detail"]["upcoming_sessions"].arrayValue {
            let d = SubjectSearchUpcomingSessionModel()
            d.objectMapping(json: data)
            upcoming_sessions.append(d)
        }
        for data in json["subject_detail"]["upcoming_assignments"].arrayValue {
            let d = SubjectSearchUpcomingAssignment()
            d.objectMapping(json: data)
            upcoming_assignments.append(d)
        }
        for data in json["subject_detail"]["questions"].arrayValue {
            let d = SubjectSearchQuestionsModel()
            d.objectMapping(json: data)
            questions.append(d)
        }
    }
}

class SubjectSearchUpcomingSessionModel: NSObject {
    var chapter_id = ""
    var subject_grade_id = ""
    var chapter_name = ""
    var chapter_desc = ""
    var subject_id = ""
    var subject_name = ""
    var class_session_start = ""
    var class_session_end = ""
    
    func objectMapping(json: JSON) {
        chapter_id = json["chapter_id"].stringValue
        subject_grade_id = json["subject_grade_id"].stringValue
        chapter_name = json["chapter_name"].stringValue
        chapter_desc = json["chapter_desc"].stringValue
        subject_id = json["subject_id"].stringValue
        subject_name = json["subject_name"].stringValue
        class_session_start = json["class_session_start"].stringValue
        class_session_end = json["class_session_end"].stringValue
    }
}

class SubjectSearchUpcomingAssignment: NSObject {
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

class SubjectSearchQuestionsModel: NSObject {
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
