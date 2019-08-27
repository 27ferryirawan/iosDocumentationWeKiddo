//
//  CalendarModel.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 22/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation
import SwiftyJSON

class CalendarModel: NSObject {
    var event_date = ""
    var personal_notes = [PersonalNotesModel]()
    var assignment = [AssignmentInCalendarModel]()
    var announcement = [AnnouncementInCalendarModel]()
    var competition = [CompetitionInCalendarModel]()
    var course_schedule = [CourseScheduleInCalendarModel]()
    var exams = [ExamInCalendarModel]()
    var sessions = [SessionsInCalendarModel]()
    var events = [EventsInCalendarModel]()
    
    func objectMapping(json: JSON) {
        event_date = json["calendar"]["date"].stringValue

        for data in json["calendar"]["personal_notes"].arrayValue {
            let d = PersonalNotesModel()
            d.objectMapping(json: data)
            personal_notes.append(d)
        }
        for data in json["calendar"]["assignments"].arrayValue {
            let d = AssignmentInCalendarModel()
            d.objectMapping(json: data)
            assignment.append(d)
        }
        for data in json["calendar"]["announcements"].arrayValue {
            let d = AnnouncementInCalendarModel()
            d.objectMapping(json: data)
            announcement.append(d)
        }
        for data in json["calendar"]["courses"].arrayValue {
            let d = CourseScheduleInCalendarModel()
            d.objectMapping(json: data)
            course_schedule.append(d)
        }
        for data in json["calendar"]["sessions"].arrayValue {
            let d = SessionsInCalendarModel()
            d.objectMapping(json: data)
            sessions.append(d)
        }
        for data in json["calendar"]["competitions"].arrayValue {
            let d = CompetitionInCalendarModel()
            d.objectMapping(json: data)
            competition.append(d)
        }
        for data in json["calendar"]["exams"].arrayValue {
            let d = ExamInCalendarModel()
            d.objectMapping(json: data)
            exams.append(d)
        }
        for data in json["calendar"]["events"].arrayValue {
            let d = EventsInCalendarModel()
            d.objectMapping(json: data)
            events.append(d)
        }
    }
}

class PersonalNotesModel: NSObject {
    var event_id = ""
    var event_name = ""
    var event_media = ""
    var start_event_date = ""
    var end_event_date = ""
    var event_due_date = ""
    var amount = ""
    var desc = ""
    var event_latlong = ""
    var school_level_id = ""
    var school_class_id = ""
    
    func objectMapping(json: JSON) {
        event_id = json["event_id"].stringValue
        event_name = json["event_name"].stringValue
        event_media = json["event_media"].stringValue
        start_event_date = json["start_event_date"].stringValue
        end_event_date = json["end_event_date"].stringValue
        event_due_date = json["event_due_date"].stringValue
        amount = json["amount"].stringValue
        desc = json["desc"].stringValue
        event_latlong = json["event_latlong"].stringValue
        school_level_id = json["school_level_id"].stringValue
        school_class_id = json["school_class_id"].stringValue
    }
}

class AssignmentInCalendarModel: NSObject {
    var school_assignment_id = ""
    var school_class_session_id = ""
    var assignment_due_date = ""
    var assignment_name = ""
    var assignment_desc = ""
    var assignment_image = ""
    var assignment_date = ""
    
    func objectMapping(json: JSON) {
        school_assignment_id = json["school_assignment_id"].stringValue
        school_class_session_id = json["school_class_session_id"].stringValue
        assignment_due_date = json["assignment_due_date"].stringValue
        assignment_name = json["assignment_name"].stringValue
        assignment_desc = json["assignment_desc"].stringValue
        assignment_image = json["assignment_image"].stringValue
        assignment_date = json["assignment_date"].stringValue
    }
}

class AnnouncementInCalendarModel: NSObject {
    var school_announcement_id = ""
    var school_announcement_subject = ""
    var school_announcement_desc = ""
    var school_announcement_media_id = ""
    var school_announcement_content = ""
    var school_announcement_date = ""
    var created_by = ""
    var school_id = ""
    var need_approval = ""
    var approval_due_date = ""
    var event_date = ""

    func objectMapping(json: JSON) {
        school_announcement_id = json["school_announcement_id"].stringValue
        school_announcement_subject = json["school_announcement_subject"].stringValue
        school_announcement_desc = json["school_announcement_desc"].stringValue
        school_announcement_media_id = json["school_announcement_media_id"].stringValue
        school_announcement_content = json["school_announcement_content"].stringValue
        school_announcement_date = json["school_announcement_date"].stringValue
        created_by = json["created_by"].stringValue
        school_id = json["school_id"].stringValue
        need_approval = json["need_approval"].stringValue
        approval_due_date = json["approval_due_date"].stringValue
        event_date = json["event_date"].stringValue
    }
}

class CompetitionInCalendarModel: NSObject {
    var school_announcement_id = ""
    var school_announcement_subject = ""
    var school_announcement_desc = ""
    var school_announcement_media_id = ""
    var school_announcement_content = ""
    var school_announcement_date = ""
    var created_by = ""
    var school_id = ""
    var need_approval = ""
    var approval_due_date = ""
    var event_date = ""
    
    func objectMapping(json: JSON) {
        school_announcement_id = json["school_announcement_id"].stringValue
        school_announcement_subject = json["school_announcement_subject"].stringValue
        school_announcement_desc = json["school_announcement_desc"].stringValue
        school_announcement_media_id = json["school_announcement_media_id"].stringValue
        school_announcement_content = json["school_announcement_content"].stringValue
        school_announcement_date = json["school_announcement_date"].stringValue
        created_by = json["created_by"].stringValue
        school_id = json["school_id"].stringValue
        need_approval = json["need_approval"].stringValue
        approval_due_date = json["approval_due_date"].stringValue
        event_date = json["event_date"].stringValue
    }
}

class CourseScheduleInCalendarModel: NSObject {
    var course_session_id = ""
    var course_session_name = ""
    var course_day = ""
    var course_session_start = ""
    var course_session_end = ""
    var course_id = ""

    func objectMapping(json: JSON) {
        course_session_id = json["course_session_id"].stringValue
        course_session_name = json["course_session_name"].stringValue
        course_day = json["course_day"].stringValue
        course_session_start = json["course_session_start"].stringValue
        course_session_end = json["course_session_end"].stringValue
        course_id = json["course_id"].stringValue
    }
}

class SessionsInCalendarModel: NSObject {
    var subject_name = ""
    var class_session_start = ""
    var class_session_end = ""
    var session_weekdays = ""
    
    func objectMapping(json: JSON) {
        subject_name = json["subject_name"].stringValue
        class_session_start = json["class_session_start"].stringValue
        class_session_end = json["class_session_end"].stringValue
        session_weekdays = json["session_weekdays"].stringValue
    }
}

class ExamInCalendarModel: NSObject {
    var school_exam_id = ""
    var school_exam_date = ""
    var school_exam_subject = ""
    var school_exam_type = ""
    var school_exam_desc = ""
    var school_class_id = ""
    var start_time = ""
    var end_time = ""
    
    func objectMapping(json: JSON) {
        school_exam_id = json["school_exam_id"].stringValue
        school_exam_date = json["school_exam_date"].stringValue
        school_exam_subject = json["school_exam_subject"].stringValue
        school_exam_type = json["school_exam_type"].stringValue
        school_exam_desc = json["school_exam_desc"].stringValue
        school_class_id = json["school_class_id"].stringValue
        start_time = json["start_time"].stringValue
        end_time = json["end_time"].stringValue
    }
}

class EventsInCalendarModel: NSObject {
    var event_id = ""
    var event_name = ""
    var event_media = ""
    var start_event_date = ""
    var end_event_date = ""
    var event_due_date = ""
    var amount = ""
    var desc = ""
    var event_latlong = ""
    var school_level_id = ""
    var school_class_id = ""
    
    func objectMapping(json: JSON) {
        event_id = json["event_id"].stringValue
        event_name = json["event_name"].stringValue
        event_media = json["event_media"].stringValue
        start_event_date = json["start_event_date"].stringValue
        end_event_date = json["end_event_date"].stringValue
        event_due_date = json["event_due_date"].stringValue
        amount = json["amount"].stringValue
        desc = json["desc"].stringValue
        event_latlong = json["event_latlong"].stringValue
        school_level_id = json["school_level_id"].stringValue
        school_class_id = json["school_class_id"].stringValue
    }
}
