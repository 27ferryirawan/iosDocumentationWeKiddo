//
//  ACUrl.swift
//  AYO CLEAN
//
//  Created by Zein Rezky Chandra on 23/05/18.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import Foundation

class ACUrl: NSObject {

    static let isProduction = false
    static let MAIN = isProduction ? "http://54.169.210.190/backend-wekiddo/public" : "http://3.1.194.152/backend-wekiddo/public"
    static let PARENT_APP = MAIN + "/api/administrator/"
    
    /* API */
    
    // LOGIN
    static let PARENT_LOGIN = PARENT_APP + "auth/login" // [POST] token_device, phone, password, user_agent
    static let PARENT_FORGOT_PASSWORD = PARENT_APP + "auth/forgetPassword" // [POST] phone, password
    static let PARENT_DASHBOARD = PARENT_APP + "home/dashboard" // [POST] user_id, role
    static let PARENT_TASKLIST_MORE = PARENT_APP + "home/tasklist-more" // [POST] user_id, school_id, year_id
    static let TEACHER_GET_ATTENDANCE = PARENT_APP + "user/attendance" // [POST] user_id, role
    static let PARENT_ABSENCE_DETAIL = PARENT_APP + "home/absence-detail" // [POST] user_id, school_id, child_id, year_id
    static let TEACHER_GET_DETAIL_ATTENDANCE = PARENT_APP + "user/attendanceDetail" // [POST] user_id, role, school_session_id
    static let TEACHER_GET_PERMISSION = PARENT_APP + "user/permissionRequest" // [POST] user_id, role
    static let TEACHER_UPDATE_STUDENT_ATTENDANCE_STATUS = PARENT_APP + "user/attendanceStudent" // [POST] user_id, role, school_session_id, child_id, is_attend, attendance_type, note
    static let TEACHER_CONFIRM_ATTENDANCE = PARENT_APP + "user/confirmAttendance" // [POST] user_id, role, school_session_id
    static let TEACHER_GET_PERMISSION_DETAIL = PARENT_APP + "user/permissionDetail" // [POST] user_id, role, permission_id
    static let TEACHER_UPDATE_PERMISSION_STATUS = PARENT_APP + "user/permissionAction" // [POST] user_id, role, permission_id, action
    static let SEARCH_PERMISSION = PARENT_APP + "user/searchPermission" // [POST] user_id, role, key
    static let SEE_MORE_UPCOMING_SESSION = PARENT_APP + "user/currentSessionMore" // [POST] user_id, role, school_id, year_id, page
    
    // PERMISSION RULES
    /*
     Permission status :
     0 = Pending
     1 = Approve
     2 = Reject
     
     Permission type :
     1 = sick
     2 = leave
     3 = alpha
     */
    static let GET_ASSIGNMENT = PARENT_APP + "user/assignment"
    static let GET_ASSIGNMENT_DETAIL = PARENT_APP + "user/assignmentDetail" // [POST] user_id, role, assign_id
    static let GET_SUBJECT_LIST = PARENT_APP + "user/subjectList" // [POST] user_id, role
    static let GET_CHAPTER_LIST = PARENT_APP + "user/chapterList" // [POST] user_id, role, subject_id
    static let SAVE_ASSIGNMENT = PARENT_APP + "user/assignmentSave" // [POST] subject_id, chapter_id, assignment_type, assignment_id, user_id, note, school_class : [school_class_id, due_date]
    static let GET_SCORES = PARENT_APP + "user/scoreList" // [POST] user_id, role, assign_id, class_id
    static let POST_UPDATE_SCORE = PARENT_APP + "user/assignmentScore"
    static let POST_ATTACHMENT_ASSIGNMENT_LIST = PARENT_APP + "user/attachmentList" // [POST] user_id, role, assign_id
    static let POST_ADD_ATTACHMENT = PARENT_APP + "user/assignmentAttachment" // [POST] user_id, role, assign_id, media_type, media_file
    static let POST_CLOSE_ASSIGNMENT = PARENT_APP + "user/assignmentClose" // [POST] user_id, role, assign_id, class_id
    static let POST_DELETE_ASSIGNMENT_ATTACHMENT = PARENT_APP + "user/deleteAssignmentAttachment" // [POST] user_id, role, attachment_id
    static let POST_GET_ASSIGNMENT_DETAIL_FOR_EDIT = PARENT_APP + "user/assignmentEdit" // [POST] user_id, role, assign_id
    static let POST_DETENTION_LIST = PARENT_APP + "user/detentionList" // [POST] user_id, role, school_id, year_id
    static let POST_SEARCH_STUDENT = PARENT_APP + "user/detentionSearchStudent" // [POST] user_id, role, school_id, year_id, keyword
    static let POST_ADD_DETENTION = PARENT_APP + "user/addDetention" // [POST] user_id, role, school_id, year_id, student_list
    static let POST_ANNOUNCEMENT_LISTS = PARENT_APP + "announcement/list" // [POST] user_id, role, school_id, year_id
    static let POST_GET_ANNOUNCEMENT_DETAIL_FOR_EDIT = PARENT_APP + "announcement/edit" // [POST] user_id, role, school_id, year_id, school_id, year_id, announcement_id
    static let POST_ADD_ANNOUNCEMENT_LEVEL_LIST = PARENT_APP + "announcement/levelList" // [POST] user_id, role, school_id, year_id
    static let POST_ADD_ANNOUNCEMENT_CLASS_LIST = PARENT_APP + "announcement/classList" // [POST] user_id, role, school_id, year_id, level_id
    static let POST_ANNOUNCEMENT_SEARCH_STUDENT = PARENT_APP + "announcement/searchStudent" // [POST] user_id, role, school_id, year_id, class_id, keyword
    static let POST_UPLOAD_ATTACHMENT_MEDIA_ANNOUNCEMENT = PARENT_APP + "announcement/uploadMedia" // [POST] user_id, role, school_id, year_id, media_type (MT3 = Banner Image, MT2 = Content Image, MT1 = video), media_file
    static let POST_GET_TEACHER_ON_DUTY_CHILD_LIST = PARENT_APP + "teacher-on-duty/get-child" // [POST] school_class_id, school_id, year_id, user_id, role
    static let POST_GET_TEACHER_ON_DUTY_PICKER_LIST = PARENT_APP + "teacher-on-duty/get-class" // [POST] school_id, year_id, user_id, role
    static let POST_ADD_TEACHER_ON_DUTY_PERMISSION = PARENT_APP + "teacher-on-duty/update-student-absence" // [POST] child_id, school_id, year_id, user_id, role, reason, desc
    static let POST_ANNOUNCEMENT_ADD = PARENT_APP + "announcement/add" // [POST] user_id, role, school_id, year_id, announcement_id, announcement_title, announcement_desc, banner_list, content_list, video_list, level, class, childs, additionals, start_date, end_date
    static let PARENT = PARENT_APP + "getParent?" // [GET] child_id=
    static let PARENT_CHECK_PHONE = PARENT_APP + "auth/checkPhone" // [POST] user_id, role, school_id, year_id, phone
    static let PARENT_SET_NEW_PASSWORD = PARENT_APP + "profile/change-password" // [POST] user_id, role, school_id, year_id, new_password, phone
    static let ADMIN_GET_MORE_EVENTS = PARENT_APP + "event-monitoring/more-event" // [POST] user_id, school_id, role, year_id
    static let ADMIN_GET_DETAIL_EVENT = PARENT_APP + "event-monitoring/detail-event" // [POST] user_id, school_id, role, year_id, event_id
    static let ADMIN_GET_SPECIFIC_EVENT_COUNT = PARENT_APP + "event-monitoring/event-count" // [POST] user_id, school_id, role, year_id, event_id, target_id
    static let ADMIN_ADD_EVENT = PARENT_APP + "event-monitoring/add-event" // [POST] user_id, role, school_id, year_id, event_id, event_title, event_desc, banner_list, content_list, video_list, level, class, additionals, start_event_date, end_event_date, event_due_date, event_latlong, amount
    static let ADMIN_EVENT_MONITORING_ADD_GALLERY = PARENT_APP + "event-monitoring/add-gallery"
    static let POST_MEDIA_FILE_FEEDBACK = PARENT_APP + "feedback/uploadMedia"
    static let ADMIN_EVENT_MONITORING_UPLOAD_FILE_EVENT = PARENT_APP + "event-monitoring/upload-file-event"
    static let SCHOOL_GET_MORE_NEWS = PARENT_APP + "news/more-news" // [POST] user_id, role, school_id, year_id
    static let GET_MORE_LATE_PAYMENT = PARENT_APP + "late-payment/list-late-payment" // [POST] user_id, role, year_id, school_id
    static let GET_LATE_PAYMENT_DETAIL = PARENT_APP + "late-payment/detail-late-payment" // [POST] user_id, school_id, role, year_id, child_payment_id
    static let UPDATE_STATUS_PAYMENT = PARENT_APP + "late-payment/update-late-payment" // [POST] user_id, role, school_id, year_id, child_payment_id, payment_notes, payment_date
    static let ADD_NEW_PAYMENT = PARENT_APP + "late-payment/add-late-payment" // [POST] user_id, role, school_id,
    static let GET_CHILD_EVENT_SEARCH = PARENT_APP + "event-monitoring/get-child-event"
    
    static let GET_EXAM_SCHEDULE_LIST = PARENT_APP + "exam/byCriteria" // [POST] user_id, school_id, role, year_id, level_id, subject_id
    static let GET_EXAM_SCHEDULE_DETAIL = PARENT_APP + "exam/detail" // [POST] user_id, school_id, role, year_id, exam_id
    static let GET_EXAM_SCORE_REMEDY = PARENT_APP + "exam/listScoreRemedy" // [POST] user_id, school_id, role, year_id, school_class_id, exam_remedy_id
    static let EXAM_ADD_REMEDY_STUDENT = PARENT_APP + "exam/addStudent" // [POST] user_id, school_id, role, year_id, exam_remedy_id, childs
    static let EXAM_UPDATE_EXAM_SCORE = PARENT_APP + "exam/examScore" // [POST] 
    static let EXAM_GET_LIST_STUDENT_FOR_ADD_NEW_SCORE = PARENT_APP + "exam/listScore" // [POST] user_id, school_id, role, year_id, school_class_id, exam_id
    static let EXAM_UPDATE_REMEDI_SCORE = PARENT_APP + "exam/remedyScore" 
    static let EXAM_GET_DATA_FOR_EDIT = PARENT_APP + "exam/edit" // [POST] user_id, school_id, role, year_id, exam_id
    static let EXAM_ADD_REMEDY = PARENT_APP + "exam/addRemedy" // [POST] user_id, school_id, year_id, role, exam_remedy_id, title, remedy_date, remarks, exam_id
    static let EXAM_CLOSE = PARENT_APP + "exam/close" // [POST] user_id, school_id, role, year_id, exam_id
    static let EXAM_TYPE_LIST = PARENT_APP + "exam/listSubject"
    static let EXAM_MAJOR_LIST = PARENT_APP + "exam/listClass" // [POST] user_id, school_id, role, year_id, school_level_id, subject_id
    static let EXAM_SAVE_NEW = PARENT_APP + "exam/save"
    static let SAVE_EVENT_PAYMENT = PARENT_APP + "event-monitoring/save-event-payment" // [POST] user_id, role, school_id, year_id, event_id, student_list
    static let CHECK_VERSION = PARENT_APP + "user/checkVersion"
    
    // PARENT CHAT
    static let PARENT_CHAT_CLASSROOM = PARENT_APP + "getClassroom?" // [GET] student_id=
    
    // DASHBOARD PARENT
    static let PARENT_GET_HOME_DATA = PARENT_APP + "Dashboard?" // [GET] child_id=&role_id
    static let PARENT_GET_CHILD = PARENT_APP + "getChild?" // [GET] parent_id=
    static let PARENT_GET_CLASSROOM = PARENT_APP + "getClassroom?" // [GET] child_id=
    static let PARENT_GET_HOME_PROFILE = PARENT_APP + "getHomeProfile?" // [GET] child_id=
    static let PARENT_GET_HOME_ATTENDANCE = PARENT_APP + "getHomeAttendance?" // [GET] child_id=&date=2019-03-29 11:23:00
    static let PARENT_GET_LATEST_ASSIGNMENT = PARENT_APP + "getLatestAssignment?" // [GET] child_id=
    static let PARENT_GET_LATEST_ANNOUNCEMENT = PARENT_APP + "getLatestAnnouncement?" // [GET] child_id=
    static let PARENT_GET_LATEST_SESSION = PARENT_APP + "getLatestSession?" // [GET] child_id=
    static let PARENT_GET_APPROVAL_COUNT = PARENT_APP + "getApprovalCount?" // [GET] child_id=
    static let PARENT_GET_COUNT_PERMISSION_APPROVAL = PARENT_APP + "getPermissionCount?" // [GET] child_id=
    static let PARENT_GET_EXAM = PARENT_APP + "get-exam?" //  [GET] child_id=
    static let PARENT_GET_EXAM_DETAIL = PARENT_APP + "get-exam-detail?" // [GET] school_exam_id=
    
    // PROFILE
    static let PARENT_PROFILE = PARENT_APP + "getParentProfile?" // [GET] parent_id=
    static let STUDENT_PROFILE = PARENT_APP + "getProfile?" // [GET] child_id=
    static let UPDATE_PARENT_PROFILE = PARENT_APP + "updateParentProfile" // [POST] parent_id, parent_name, parent_phone, parent_email, parent_address, parent_occupation, parent_company, parent_position, parent_image
    static let PARENT_TEACHER_PROFILE = PARENT_APP + "profile/teacher-profile" // [POST] user_id, school_id, role, year_id
    static let EDIT_PROFILE_DELETE_SUBJECT_CLASS = PARENT_APP + "profile/delete-subject-class" // [POST] user_id, role, school_id, year_id, school_subject_teacher_id
    static let ADD_NEW_SUBJECT_IN_EDIT_PROFILE = PARENT_APP + "profile/add-subject-class" // [POST] school_id, year_id, role, subject_id, school_class_id, user_id
    static let SAVE_UPDATED_PROFILE = PARENT_APP + "profile/update-profile" // [POST] school_id, year_id, user_id, role, teacher_address, teacher_phone, teacher_email, teacher_image
    
    // SUBJECT
    static let PARENT_GET_SESSION_DETAIL = PARENT_APP + "getSessionDetail?" // [GET] subject_session_id=SS1
    static let PARENT_GET_SUBJECT = PARENT_APP + "getSubjectList?" // [GET] child_id=
    static let PARENT_GET_SUBJECT_SESSION = PARENT_APP + "getSession?" // [GET] session_id=
    static let PARENT_GET_SUBJECT_SESSIONS = PARENT_APP + "getSessions?" // [GET] child_id=&subject_id=
    static let PARENT_GET_SUBJECT_ASSIGNMENT = PARENT_APP + "getAssignment?" // [GET] assignment_id=&child_id=
    static let PARENT_GET_SUBJECT_ASSIGNMENT_DETAIL = PARENT_APP + "getAllAssignments?" // [GET] child_id=
    static let PARENT_GET_SUBJECTS_ALL_ASSIGNMENT = PARENT_APP + "getAllAssignments?" // [GET] child_id=&subject_id=
    static let PARENT_GET_SUBJECTS_CHILD_ASSIGNMENT = PARENT_APP + "getChildAssignments?" // [GET] child_id=
    static let PARENT_ASSIGNMENT_STATUS_UPDATE = PARENT_APP + "updateAssignmentStatus" // [POST] child_id, assignment_id, assignment_status
    static let PARENT_GET_SUBJECT_DETAIL = PARENT_APP + "getSubjectDetail?" // [GET] subject_id=SUBJECT1&child_id=C1
    static let PARENT_GET_SEARCH_SUBJECT = PARENT_APP + "search?" // [GET] keyword=a&child_id=C25&subject_id=SUBJECT1
    static let GET_SUBJECT_TEACHER_BY_SUBJET = PARENT_APP + "subject-topic/by-subject" // [POST] school_id, year_id, user_id, role
    static let GET_SUBJECT_TEACHER_BY_CLASS = PARENT_APP + "subject-topic/by-class" // [POST] school_id, year_id, user_id, role
    static let GET_SUBJECT_TEACHER_CHAPTER_LIST = PARENT_APP + "subject-topic/chapter/list" // [POST] user_id, role, school_id, year_id, school_level_id, subject_id
    static let GET_SUBJECT_TEACHER_SESSION_LIST = PARENT_APP + "subject-topic/session/list" // [POST] school_id, year_id, subject_id, school_class_id, user_id, role
    static let SAVE_SUBJECT_TEACHER_SESSION_LIST = PARENT_APP + "subject-topic/session/save" // [POST] school_id, year_id, subject_id, school_class_id, user_id, role, chapter (school_session_id, chapter_id)
    static let GET_EDIT_DATA_SUBJECT_TEACHER_DETAIL = PARENT_APP + "subject-topic/chapter/edit" // [POST] user_id, role, school_id, year_id, school_level_id, subject_id, chapter_id
    static let GET_PARAM_FOR_ADD_SUBJECT_TOPIC = PARENT_APP + "subject-topic/chapter/getparam" // [POST] user_id, role, school_id, year_id, school_grade_id, school_level_id, school_major_id, subject_id
    static let SUBJECT_TEACHER_UPLOAD_FILE = PARENT_APP + "subject-topic/chapter/uploadFile" // [POST] user_id, role, school_id, year_id, media_type, attach_title, media_file
    static let SUBJECT_TEACHER_ADD_NEW = PARENT_APP + "subject-topic/chapter/add" //
    static let SUBJECT_TEACHER_CHAPTER_DETAIL = PARENT_APP + "subject-topic/chapter/detail"
    static let GET_SPECIAL_ATTENTION_BY_SUBJECT = PARENT_APP + "user/attentionSubjectMore" // [POST] school_id, year_id,user_id,role
    static let GET_SPECIAL_ATTENTION_DETAIL_BY_SUBJECT = PARENT_APP + "user/attentionDetailSubject" // [POST] user_id, role, school_id, year_id, child_id, subject_id
    static let GET_SPECIAL_ATTENTION_BY_CLASS = PARENT_APP + "user/attentionClassMore" // [POST] school_id, year_id, user_id, role
    static let GET_SPECIAL_ATTENTION_DETAIL_BY_CLASS = PARENT_APP + "user/attentionDetailClass" // [POST] school_id, year_id, user_id, role, child_id, class_id
    static let POST_SCHOOL_FEEDBACK = PARENT_APP + "feedback/save" // [POST] user_id, feedback_id, description, media_list, id
    
    static let POST_CURRENT_CLASS_MORE = PARENT_APP + "user/currentClassMore" // [POST] user_id, role, school_id, year_id, page
 
    // ANNOUNCEMENT
    static let PARENT_GET_ANNOUNCEMENT = PARENT_APP + "getAnnouncement?" // [GET] child_id=C1
    static let PARENT_GET_ANNOUNCEMENT_DETAIL = PARENT_APP + "announcement/detail" // [GET] announcement_id=
    
    // ASSIGNMENT
    static let PARENT_GET_ASSIGNMENT = PARENT_APP + "allAssignment?" // [GET] child_id=C1
    static let PARENT_GET_DETAIL_ASSIGNMENT = PARENT_APP + "getDetailAssignment?" // [GET] school_assignment_id
    static let PARENT_GET_ASSIGNMENT_STUDENT_NOTE = PARENT_APP + "get-shared-notes?" // [GET] child_id=C2&chapter_id=CHAPTER2
    static let PARENT_GET_ASSIGNMENT_ATTACHMENT = PARENT_APP + "getAssignmentAttachments?" // [GET] school_assignment_id=ASSIGNMENT2
    
    // APPROVAL
    static let PARENT_GET_APPROVAL = PARENT_APP + "getApproval?" // [GET] child_id=C1
    static let PARENT_GET_APPROVAL_DETAIL = PARENT_APP + "getApprovalDetail?" // [GET] approval_status_id=
    static let PARENT_UPDATE_APPROVAL = PARENT_APP + "approve?" // [POST] approval_status_id
    static let PARENT_GET_EVENT_APPROVAL_DETAIL = PARENT_APP + "getEventApprovalDetail?" // [GET] event_id=E1&child_id=C1
    
    // PERMISSION
    static let PARENT_GET_PERMISSION = PARENT_APP + "getPermission?" // [GET] child_id=
    static let PARENT_GET_PERMISSION_COUNT = PARENT_APP + "getPermissionCount?" // [GET] child_id=
    static let PARENT_ADD_NEW_PERMSSION = PARENT_APP + "addPermission" // [POST] child_id, permission_date, permission_type, permission_reason, attachment
    
    // MEDICAL
    static let PARENT_GET_MEDICAL_RECORD = PARENT_APP + "getMedicalRecord?" // [GET] child_id=
    static let PARENT_ADD_MEDICAL_RECORD = PARENT_APP + "addMedicalRecord" // [POST] child_id, medical_date, symptom, medical_action, medicine, hospital, doctor, diagnose, recipe
    
    // FUTURE PLAN
    static let PARENT_GET_FUTURE_PLAN_ACADEMYC = PARENT_APP + "getAcademic?" // [GET]
    static let PARENT_GET_FUTURE_PLAN_TALENT = PARENT_APP + "getTalent?" // [GET]
    static let PARENT_GET_FUTURE_PLAN_CAREER = PARENT_APP + "getCareer?" // [GET]
    static let PARENT_GET_FUTURE_PLAN_CAREER_DETAIL = PARENT_APP + "getCareerDetail?" // [GET] career_id=
    static let PARENT_GET_FUTURE_PLAN_CAREER_BY_ACADEMYC = PARENT_APP + "getCareerAcademic?" // [GET] academic_id=
    static let PARENT_GET_FUTURE_PLAN_CAREER_BY_TALENT = PARENT_APP + "getCareerTalent?" // [GET] talent_id=
    static let PARENT_GET_FUTURE_PLAN_CAREER_MAJOR = PARENT_APP + "getCareerMajor?" // [GET] career_id=
    static let PARENT_GET_FUTURE_PLAN_MAJOR_UNIVERSITY = PARENT_APP + "getMajorUniversity?" // [GET] major_id=
    static let PARENT_GET_FUTURE_PLAN_UNIVERSITY_DETAIL = PARENT_APP + "getUniversity?" // [GET] university_id=
    
    // NEARBY COURSE
    static let PARENT_GET_NEARBY_COURSE = PARENT_APP + "getNearbyCourses" // [GET]
    static let PARENT_GET_NEARBY_SEARCH = PARENT_APP + "searchCourse?" // [GET] keyword=
    static let PARENT_GET_NEARBY_COURSE_DETAIL = PARENT_APP + "getCourseDetail?" // [GET] course_id=
    static let PARENT_ADD_NEARBY_COURSE = PARENT_APP + "applyCourse" // [POST] child_id, course_id
    static let PARENT_GET_NEARBY_COURSE_MORE = PARENT_APP + "getMoreCourses?" // course_category_id =
    
    // COMPETITION
    static let PARENT_GET_COMPETITION_CATEGORY = PARENT_APP + "getCompetitionCategory?" // [GET]
    static let PARENT_GET_COMPETITION = PARENT_APP + "getCompetition?" // [GET] competition_category_id=
    static let PARENT_GET_COMPETITION_DETAIL = PARENT_APP + "getCompetitionDetail?" // [GET] competition_id=
    
    // SCHOLARSHIP
    static let PARENT_GET_SCHOLARSHIP = PARENT_APP + "getScholarship?" // [GET]
    static let PARENT_GET_SCHOLARSHIP_DETAIL = PARENT_APP + "getScholarshipDetail?" // [GET] scholarship_id=
    static let PARENT_REGISTER_SCHOLARSHIP = PARENT_APP + "applyScholarship" // [POST] child_id, scholarship_id, university_id, reason
    
    // ATTENDANCE
    static let PARENT_GET_ATTENDANCE = PARENT_APP + "getTodayAttendance?" // [GET] child_id=
    static let PARENT_GET_ABSENT_HISTORY = PARENT_APP + "getAbsentHistory?" // [GET] child_id=
    static let PARENT_GET_LATE_INFO = PARENT_APP + "getLateInfo?" // [GET] child_id=
    
    // TRANSACTION
    static let PARENT_GET_CREDIT = PARENT_APP + "getCredit?" // [GET] child_id=
    static let PARENT_GET_SUBSCRIPTION = PARENT_APP + "getSubscription?" // [GET] parent_id=
    static let PARENT_GET_TRANSACTIONS = PARENT_APP + "getTransactionHistory?" // [GET] child_id=
    
    // CALENDAR
    static let PARENT_GET_CALENDAR_EVENTS = PARENT_APP + "getCalendarEvents?" // [GET] child_id=
    static let PARENT_ADD_NEW_CALENDAR_EVENT = PARENT_APP + "addCalendar" // [POST] child_id, event_title, event_type, event_start, event_end, event_repeat, event_reminder, event_desc
    static let PARENT_GET_CALENDAR_AGENDA_LIST = PARENT_APP + "getAgendaList?" // [GET] child_id=
    
    // SCORE
    static let PARENT_GET_SCORE = PARENT_APP + "getScore?" // [GET] student_id=
    static let PARENT_GET_SCORE_SUBJECT = PARENT_APP + "getScoreSubject?" // [GET] student_id=&subject_id=
    static let PARENT_GET_SCORE_SUMMARY = PARENT_APP + "getScoreSummaries?" // [GET] child_id=
    static let PARENT_DELETE_SCORE = PARENT_APP + "archive-scores/store" // [POST] subject_id, score_type_id, child_id
    
    // UPLOAD
    static let UPLOAD = PARENT_APP + "uploadFile" // [POST] image
    
    // FOOD
    static let PARENT_GET_FOOD_LIST = PARENT_APP + "getFoodList?" // [GET] child_id=
    static let PARENT_GET_FOOD_DETAIL = PARENT_APP + "getFoodDetail?" // [GET] food_id=
    static let PARENT_GET_FOOD_CATEGORIES = PARENT_APP + "getFoodCategory?" // [GET] child_id=
    static let PARENT_GET_FOOD_HISTORY = PARENT_APP + "getFoodTransactionHistory?" // [GET] child_id=
    static let PARENT_FOOD_CONTROL = PARENT_APP + "getFoodControl?" // [GET] child_id=
    static let PARENT_ADD_FOOD_TRANSACTION = PARENT_APP + "addFoodTransaction" // [POST]
    /*
     {
     "child_id": "C1",
     "catering_id": "CATERING1",
     "total_price": "45000",
     "foods": [
     {
     "food_id": "FOOD1",
     "quantity":1,
     "catering_date": "2019-03-30 00:00:00"
     },
     {
     "food_id": "FOOD2",
     "quantity":1,
     "catering_date": "2019-03-30 00:00:00"
     }
     ]
     }
     */
    
    static let PARENT_ADD_FOOD_CONTROL = PARENT_APP + "addFoodControl" // [POST]
    /*
     {
     "child_id": "C1",
     "food_controls": [
     {
     "category_detail_id": "1"
     },
     {
     "category_detail_id": "2"
     },
     {
     "category_detail_id": "6"
     }
     ]
     }
     */
    
    // NEWS
    static let PARENT_GET_NEWS = PARENT_APP + "getNews?" // [GET] role_id=
    static let PARENT_GET_NEWS_DETAIL = PARENT_APP + "getNewsDetail?" // [GET] news_id=
    
    // QUESTIONS
    static let PARENT_ADD_QUESTION = PARENT_APP + "addQuestion" // [POST] child_id, question_subject, question, question_topic
    
    // AGENCY
    static let PARENT_GET_AGENCY = PARENT_APP + "getAgency?" // [GET]
    static let PARENT_GET_AGENCY_DETAIL = PARENT_APP + "getAgencyDetail?" // [GET] agency_id=
    
    // LOGIN INFO
    static let PARENT_GET_LOGIN_INFO = PARENT_APP + "getSchool" // [GET]
    static let PARENT_GET_SCHOOL_DETAIL = PARENT_APP + "getDetailSchool?" // [GET] school_id=SCHOOL1
    static let PARENT_POST_SCHOOL_REGISTER = PARENT_APP + "RegisSchool?" // [POST]
    
    
    // FCM
    static let FCM_STORE_TOKEN = PARENT_APP + "storeToken" // [POST] user_id, user_agent, token
    
    // NOTIFICATION
    static let PARENT_GET_NOTIFICATION_LIST = PARENT_APP + "notification/parent?" // [GET] parent_id
    
    // MARK: - ADMINISTRATOR
    
    // ASSIGNMENT
    static let ADMIN_GET_ASSIGNMENT_LIST = PARENT_APP + "assignment/list" //[GET] user_id, school_id, year_id, school_user_id
    static let ADMIN_GET_ASSIGNMENT_TEACHER_LIST = PARENT_APP + "assignment/teacher-list" //[GET] school_id, user_id, year_id
    static let ADMIN_GET_ASSIGNMENT_DETAIL = PARENT_APP + "assignment/detail" //[GET] user_id, school_user_id, assign_id, class_id
    static let ADMIN_GET_ASSIGNMENT_GET_TEACHER = PARENT_APP + "assignment/get-teacher" //[GET] user_id, school_id, year_id
    static let ADMIN_GET_ASSIGNMENT_GET_SUBJECT_CLASS = PARENT_APP + "assignment/get-subject-class" //[GET] user_id, school_user_id, school_id, year_id
    static let ADMIN_GET_ASSIGNMENT_GET_CHAPTER = PARENT_APP + "assignment/get-chapter"//[GET] user_id, school_user_id, school_id, year_id, subject_id
    static let ADMIN_GET_ASSIGNMENT_EDIT = PARENT_APP + "assignment/edit"//[GET] user_id, school_user_id, school_id, year_id, assign_id
    static let ADMIN_GET_ASSIGNMENT_GET_ATTACHMENT = PARENT_APP + "assignment/get-attachment" //[GET] user_id, school_user_id, assign_id
    static let ADMIN_POST_ASSIGNMENT_SAVE = PARENT_APP + "assignment/save" //[POST] user_id, school_user_id, school_id, year_id, assignment_id, subject_id, chapter_id, assignmentType, note, school_class{ school_class_id, due_date}
    static let ADMIN_POST_ASSIGNMENT_SAVE_ATTACHMENT = PARENT_APP + "assignment/save-attachment"//[POST]
    static let ADMIN_POST_ASSIGNMENT_DELETE_ATTACHMENT = PARENT_APP + "assignment/delete-attachment"//[POST] user_id, school_user_id, attachment_id
    static let ADMIN_GET_ASSIGNMENT_GET_SCORE = PARENT_APP + "assignment/get-score"//[GET] user_id, school_user_id, assign_id, school_id, year_id, class_id
    static let ADMIN_POST_ASSIGNMENT_SAVE_SCORE = PARENT_APP + "assignment/save-score"//[POST]
    static let ADMIN_POST_ASSIGNMENT_CLOSE = PARENT_APP + "assignment/close"
}
