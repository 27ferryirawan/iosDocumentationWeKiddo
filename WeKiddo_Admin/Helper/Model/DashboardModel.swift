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
    var home_profile_year_id = ""
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
        home_profile_year_id = json["data"]["school_info"]["year_id"].stringValue

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

class DashboardCoordinatorModel: NSObject {
    var day = ""
    var total_school = 0
    var date = ""
    var student_total_download_percent = 0
    var student_total_active_percent = 0
    var student_total_login = 0
    var student_total_download = 0
    var student_total_active = 0
    var student_total_user = 0
    var student_total_login_percent = 0

    var teacher_total_download_percent = 0
    var teacher_total_active_percent = 0
    var teacher_total_login = 0
    var teacher_total_download = 0
    var teacher_total_active = 0
    var teacher_total_user = 0
    var teacher_total_login_percent = 0
    
    var ebook_school_with_ebook_percent = 0
    var ebook_total_student_download = 0
    
    var parent_total_download_percent = 0
    var parent_total_active_percent = 0
    var parent_total_login = 0
    var parent_total_download = 0
    var parent_total_active = 0
    var parent_total_user = 0
    var parent_total_login_percent = 0

    var exercise_total_student_do_exercise = 0
    var exercise_school_created_exercise_percent = 0
    
    var assignment_worksheet_submission_percent = 0
    var assignment_average_assignment = 0
    
    func objectMapping(json: JSON) {
        day = json["data"]["school_monitoring"]["day"].stringValue
        total_school = json["data"]["school_monitoring"]["total_school"].intValue
        date = json["data"]["school_monitoring"]["date"].stringValue
        student_total_download_percent = json["data"]["school_monitoring"]["student"]["total_download_percent"].intValue
        student_total_active_percent = json["data"]["school_monitoring"]["student"]["total_active_percent"].intValue
        student_total_login = json["data"]["school_monitoring"]["student"]["total_login"].intValue
        student_total_download = json["data"]["school_monitoring"]["student"]["total_download"].intValue
        student_total_active = json["data"]["school_monitoring"]["student"]["total_active"].intValue
        student_total_user = json["data"]["school_monitoring"]["student"]["total_user"].intValue
        student_total_login_percent = json["data"]["school_monitoring"]["student"]["total_login_percent"].intValue
        
        teacher_total_download_percent = json["data"]["school_monitoring"]["teacher"]["total_download_percent"].intValue
        teacher_total_active_percent = json["data"]["school_monitoring"]["teacher"]["total_active_percent"].intValue
        teacher_total_login = json["data"]["school_monitoring"]["teacher"]["total_login"].intValue
        teacher_total_download = json["data"]["school_monitoring"]["teacher"]["total_download"].intValue
        teacher_total_active = json["data"]["school_monitoring"]["teacher"]["total_active"].intValue
        teacher_total_user = json["data"]["school_monitoring"]["teacher"]["total_user"].intValue
        teacher_total_login_percent = json["data"]["school_monitoring"]["teacher"]["total_login_percent"].intValue
        
        ebook_school_with_ebook_percent = json["data"]["school_monitoring"]["ebook"]["school_with_ebook_percent"].intValue
        ebook_total_student_download = json["data"]["school_monitoring"]["ebook"]["total_student_download"].intValue

        parent_total_download_percent = json["data"]["school_monitoring"]["parent"]["total_download_percent"].intValue
        parent_total_active_percent = json["data"]["school_monitoring"]["parent"]["total_active_percent"].intValue
        parent_total_login = json["data"]["school_monitoring"]["parent"]["total_login"].intValue
        parent_total_download = json["data"]["school_monitoring"]["parent"]["total_download"].intValue
        parent_total_active = json["data"]["school_monitoring"]["parent"]["total_active"].intValue
        parent_total_user = json["data"]["school_monitoring"]["parent"]["total_user"].intValue
        parent_total_login_percent = json["data"]["school_monitoring"]["parent"]["total_login_percent"].intValue

        exercise_total_student_do_exercise = json["data"]["school_monitoring"]["exercise"]["total_student_do_exercise"].intValue
        exercise_school_created_exercise_percent = json["data"]["school_monitoring"]["exercise"]["school_created_exercise_percent"].intValue

        assignment_worksheet_submission_percent = json["data"]["school_monitoring"]["assignment"]["worksheet_submission_percent"].intValue
        assignment_average_assignment = json["data"]["school_monitoring"]["assignment"]["avg_assignment"].intValue

    }
}

class DashboardDetailSchoolModel: NSObject {
    var school_id = ""
    var school_name = ""
    var school_grade = ""
    var school_image = ""
    var day = ""
    var status = 0
    var date = ""

    var student_total_student = 0
    var student_percentage_login = 0
    var student_total_login = 0
    var student_total_download = 0
    var student_percentage_download = 0
    var student_total_active = 0
    var student_percentage_active = 0

    var teacher_total_teacher = 0
    var teacher_percentage_login = 0
    var teacher_total_login = 0
    var teacher_total_download = 0
    var teacher_percentage_download = 0
    var teacher_total_active = 0
    var teacher_percentage_active = 0
    
    var ebook_total_school_upload = 0
    var ebook_total_school_download = 0
    
    var parent_total_parent = 0
    var parent_percentage_login = 0
    var parent_total_login = 0
    var parent_total_download = 0
    var parent_percentage_download = 0
    var parent_total_active = 0
    var parent_percentage_active = 0

    var exercise_total_student_do_exercsie = 0
    var exercise_total_created_exercise = 0
    
    var assignment_worksheet_submission = 0
    var assignment_average_assignment = 0
    
    func objectMapping(json: JSON) {
        school_id = json["data"]["detail_school"]["school_id"].stringValue
        school_name = json["data"]["detail_school"]["school_name"].stringValue
        school_grade = json["data"]["detail_school"]["school_grade"].stringValue
        school_image = json["data"]["detail_school"]["school_image"].stringValue
        day = json["data"]["detail_school"]["day"].stringValue
        status = json["data"]["detail_school"]["status"].intValue
        date = json["data"]["detail_school"]["date"].stringValue

        student_total_student = json["data"]["detail_school"]["student"]["total_student"].intValue
        student_percentage_login = json["data"]["detail_school"]["student"]["percentage_login"].intValue
        student_total_login = json["data"]["detail_school"]["student"]["total_login"].intValue
        student_total_download = json["data"]["detail_school"]["student"]["total_download"].intValue
        student_percentage_download = json["data"]["detail_school"]["student"]["percentage_download"].intValue
        student_total_active = json["data"]["detail_school"]["student"]["total_active"].intValue
        student_percentage_active = json["data"]["detail_school"]["student"]["percentage_active"].intValue
                
        teacher_total_teacher = json["data"]["detail_school"]["teacher"]["total_teacher"].intValue
        teacher_percentage_login = json["data"]["detail_school"]["teacher"]["percentage_login"].intValue
        teacher_total_login = json["data"]["detail_school"]["teacher"]["total_login"].intValue
        teacher_total_download = json["data"]["detail_school"]["teacher"]["total_download"].intValue
        teacher_percentage_download = json["data"]["detail_school"]["teacher"]["percentage_download"].intValue
        teacher_total_active = json["data"]["detail_school"]["teacher"]["total_active"].intValue
        teacher_percentage_active = json["data"]["detail_school"]["teacher"]["percentage_active"].intValue

        ebook_total_school_upload = json["data"]["detail_school"]["ebook"]["total_school_upload"].intValue
        ebook_total_school_download = json["data"]["detail_school"]["ebook"]["total_school_download"].intValue

        parent_total_parent = json["data"]["detail_school"]["parent"]["total_parent"].intValue
        parent_percentage_login = json["data"]["detail_school"]["parent"]["percentage_login"].intValue
        parent_total_login = json["data"]["detail_school"]["parent"]["total_login"].intValue
        parent_total_download = json["data"]["detail_school"]["parent"]["total_download"].intValue
        parent_percentage_download = json["data"]["detail_school"]["parent"]["percentage_download"].intValue
        parent_total_active = json["data"]["detail_school"]["parent"]["total_active"].intValue
        parent_percentage_active = json["data"]["detail_school"]["parent"]["percentage_active"].intValue

        exercise_total_student_do_exercsie = json["data"]["detail_school"]["exercise"]["total_student_do_exercise"].intValue
        exercise_total_created_exercise = json["data"]["detail_school"]["exercise"]["total_created_exercise"].intValue

        assignment_worksheet_submission = json["data"]["detail_school"]["assignment"]["worksheet_submission"].intValue
        assignment_average_assignment = json["data"]["detail_school"]["assignment"]["avg_assignment"].intValue

    }
}

class DashboardCoordinatorAssignmentListModel: NSObject {
    var school_id = ""
    var school_name = ""
    var school_image = ""
    var avg_assignment = 0
    var worksheet_submission = 0
    var weekly_statistic_submission = 0
    var status = 0
    
    func objectMapping(json: JSON) {
        school_id = json["school_id"].stringValue
        school_name = json["school_name"].stringValue
        school_image = json["school_image"].stringValue
        avg_assignment = json["avg_assignment"].intValue
        worksheet_submission = json["worksheet_submission"].intValue
        weekly_statistic_submission = json["weekly_statistic_submission"].intValue
        status = json["status"].intValue
    }
}

class DashboardCoordinatorEbookListModel: NSObject {
    var school_id = ""
    var school_name = ""
    var school_image = ""
    var total_book_upd = 0
    var total_student_download = 0
    var weekly_statistic_book_download = 0
    var status = 0
    
    func objectMapping(json: JSON) {
        school_id = json["school_id"].stringValue
        school_name = json["school_name"].stringValue
        school_image = json["school_image"].stringValue
        total_book_upd = json["total_book_upd"].intValue
        total_student_download = json["total_student_download"].intValue
        weekly_statistic_book_download = json["weekly_statistic_book_download"].intValue
        status = json["status"].intValue
    }
}

class DashboardCoordinatorExerciseListModel: NSObject {
    var school_id = ""
    var school_name = ""
    var school_image = ""
    var school_create_exercise = 0
    var total_student_do_exercise = 0
    var weekly_statistic_total_student_do_exercise = 0
    var status = 0
    
    func objectMapping(json: JSON) {
        school_id = json["school_id"].stringValue
        school_name = json["school_name"].stringValue
        school_image = json["school_image"].stringValue
        school_create_exercise = json["school_create_exercise"].intValue
        total_student_do_exercise = json["total_student_do_exercise"].intValue
        weekly_statistic_total_student_do_exercise = json["weekly_statistic_total_student_do_exercise"].intValue
        status = json["status"].intValue
    }
}

class DashboardCoordinatorStudentListModel: NSObject {
    var school_id = ""
    var school_name = ""
    var school_image = ""
    var total_student = 0
    var total_login = 0
    var total_download = 0
    var total_active = 0
    var total_login_percent = 0
    var total_download_percent = 0
    var total_active_percent = 0
    var weekly_statistic_login = 0
    var weekly_statistic_active = 0
    
    func objectMapping(json: JSON) {
        school_id = json["school_id"].stringValue
        school_name = json["school_name"].stringValue
        school_image = json["school_image"].stringValue
        total_student = json["total_student"].intValue
        total_login = json["total_login"].intValue
        total_download = json["total_download"].intValue
        total_active = json["total_active"].intValue
        total_login_percent = json["total_login_percent"].intValue
        total_download_percent = json["total_download_percent"].intValue
        total_active_percent = json["total_active_percent"].intValue
        weekly_statistic_login = json["weekly_statistic_login"].intValue
        weekly_statistic_active = json["weekly_statistic_active"].intValue
    }
}

class DashboardCoordinatorTeacherListModel: NSObject {
    var school_id = ""
    var school_name = ""
    var school_image = ""
    var total_teacher = 0
    var total_login = 0
    var total_download = 0
    var total_active = 0
    var total_login_percent = 0
    var total_download_percent = 0
    var total_active_percent = 0
    var weekly_statistic_login = 0
    var weekly_statistic_active = 0
    
    func objectMapping(json: JSON) {
        school_id = json["school_id"].stringValue
        school_name = json["school_name"].stringValue
        school_image = json["school_image"].stringValue
        total_teacher = json["total_teacher"].intValue
        total_login = json["total_login"].intValue
        total_download = json["total_download"].intValue
        total_active = json["total_active"].intValue
        total_login_percent = json["total_login_percent"].intValue
        total_download_percent = json["total_download_percent"].intValue
        total_active_percent = json["total_active_percent"].intValue
        weekly_statistic_login = json["weekly_statistic_login"].intValue
        weekly_statistic_active = json["weekly_statistic_active"].intValue
    }
}

class DashboardCoordinatorParentListModel: NSObject {
    var school_id = ""
    var school_name = ""
    var school_image = ""
    var total_parent = 0
    var total_login = 0
    var total_download = 0
    var total_active = 0
    var total_login_percent = 0
    var total_download_percent = 0
    var total_active_percent = 0
    var weekly_statistic_login = 0
    var weekly_statistic_active = 0
    
    func objectMapping(json: JSON) {
        school_id = json["school_id"].stringValue
        school_name = json["school_name"].stringValue
        school_image = json["school_image"].stringValue
        total_parent = json["total_parent"].intValue
        total_login = json["total_login"].intValue
        total_download = json["total_download"].intValue
        total_active = json["total_active"].intValue
        total_login_percent = json["total_login_percent"].intValue
        total_download_percent = json["total_download_percent"].intValue
        total_active_percent = json["total_active_percent"].intValue
        weekly_statistic_login = json["weekly_statistic_login"].intValue
        weekly_statistic_active = json["weekly_statistic_active"].intValue
    }
}

class CoordinatorAssignmentListPerSchool: NSObject {
    var kelas = ""
    var list_assignment = [CoordinatorAssignmentListDataPerSchool]()
    
    func objectMapping(json: JSON) {
        kelas = json["class"].stringValue
        for data in json["list_assignment"].arrayValue {
            let d = CoordinatorAssignmentListDataPerSchool()
            d.objectMapping(json: data)
            list_assignment.append(d)
        }
    }
}

class CoordinatorAssignmentListDataPerSchool: NSObject {
    var assignment_id = ""
    var note = ""
    var subject_name = ""
    var teacher_name = ""
    var quiz_start_datetime = ""
    var quiz_end_datetime = ""
    var teacher_image = ""
    var subject_topic_name = ""
    var school_class_id = ""
    var total_student_assignment = 0
    var total_student_assignment_submission = 0
    
    func objectMapping(json: JSON) {
        assignment_id = json["assignment_id"].stringValue
        note = json["note"].stringValue
        subject_name = json["subject_name"].stringValue
        teacher_name = json["teacher_name"].stringValue
        quiz_start_datetime = json["quiz_start_datetime"].stringValue
        quiz_end_datetime = json["quiz_end_datetime"].stringValue
        teacher_image = json["teacher_image"].stringValue
        subject_topic_name = json["subject_topic_name"].stringValue
        school_class_id = json["school_class_id"].stringValue
        total_student_assignment = json["total_student_assignment"].intValue
        total_student_assignment_submission = json["total_student_assignment_submission"].intValue
    }
}

class CoordinatorAssignmentListPerClass: NSObject {
    var assignment_id = ""
    var note = ""
    var subject_name = ""
    var teacher_name = ""
    var quiz_start_datetime = ""
    var quiz_end_datetime = ""
    var teacher_image = ""
    var subject_topic_name = ""
    var school_class = ""
    var total_student_assignment = 0
    var total_student_assignment_submission = 0
    var student_lists = [CoordinatorAssignmentListStudentPerClass]()
    
    func objectMapping(json: JSON) {
        assignment_id = json["assignment_id"].stringValue
        note = json["note"].stringValue
        subject_name = json["subject_name"].stringValue
        teacher_name = json["teacher_name"].stringValue
        quiz_start_datetime = json["quiz_start_datetime"].stringValue
        quiz_end_datetime = json["quiz_end_datetime"].stringValue
        teacher_image = json["teacher_image"].stringValue
        subject_topic_name = json["subject_topic_name"].stringValue
        school_class = json["school_class"].stringValue
        total_student_assignment = json["total_student_assignment"].intValue
        total_student_assignment_submission = json["total_student_assignment_submission"].intValue
        for data in json["student_lists"].arrayValue {
            let d = CoordinatorAssignmentListStudentPerClass()
            d.objectMapping(json: data)
            student_lists.append(d)
        }
    }
}

class CoordinatorAssignmentListStudentPerClass: NSObject {
    var child_id = ""
    var child_name = ""
    var child_image = ""
    var child_nis = ""
    var is_submit = false
    
    func objectMapping(json: JSON) {
        child_id = json["child_id"].stringValue
        child_name = json["child_name"].stringValue
        child_image = json["child_image"].stringValue
        child_nis = json["child_nis"].stringValue
        is_submit = json["is_submit"].boolValue
    }
}

class CoordinatorEbookUploadListModel: NSObject {
    var book_id = 0
    var book_name = ""
    var book_image = ""
    var total_download = 0
    var total_view = 0
    var source = 0
    
    func objectMapping(json: JSON) {
        book_id = json["book_id"].intValue
        book_name = json["book_name"].stringValue
        book_image = json["book_image"].stringValue
        total_download = json["total_download"].intValue
        total_view = json["total_view"].intValue
        source = json["source"].intValue
    }

}

class CoordinatorEbookDownloadListModel: NSObject {
    var book_id = 0
    var book_name = ""
    var download_date = ""
    var book_image = ""
    var child_id = ""
    var child_name = ""
    var child_nis = ""
    var school_class_id = ""
    var school_class = ""
    var child_image = ""
    
    func objectMapping(json: JSON) {
        book_id = json["book_id"].intValue
        book_name = json["book_name"].stringValue
        book_image = json["book_image"].stringValue
        download_date = json["download_date"].stringValue
        child_id = json["child_id"].stringValue
        child_name = json["child_name"].stringValue
        child_nis = json["child_nis"].stringValue
        school_class_id = json["school_class_id"].stringValue
        school_class = json["school_class"].stringValue
        child_image = json["child_image"].stringValue
    }
}

class CoordinatorExerciseSchoolCreateListModel: NSObject {
    var subject_generic_id = 0
    var subject_name = ""
    var exercise = [CoordinatorExerciseSchoolCreateDataModel]()
    
    func objectMapping(json: JSON) {
        subject_generic_id = json["subject_generic_id"].intValue
        subject_name = json["subject_name"].stringValue

        for data in json["exercise"].arrayValue {
            let d = CoordinatorExerciseSchoolCreateDataModel()
            d.objectMapping(json: data)
            exercise.append(d)
        }

    }
}

class CoordinatorExerciseSchoolCreateDataModel: NSObject {
    var e_id = 0
    var start_date = ""
    var end_date = ""
    var exercise_name = ""
    var teacher_name = ""
    var teacher_image = ""
    var cnt_student_exercised = 0
    
    func objectMapping(json: JSON) {
        e_id = json["e_id"].intValue
        start_date = json["start_date"].stringValue
        end_date = json["end_date"].stringValue
        exercise_name = json["exercise_name"].stringValue
        teacher_name = json["teacher_name"].stringValue
        teacher_image = json["teacher_image"].stringValue
        cnt_student_exercised = json["cnt_student_exercised"].intValue
    }
}


class CoordinatorDetailExerciseSchoolCreateModel: NSObject {
    var subject_name = ""
    var list_student = [CoordinatorDetailExerciseSchoolCreateStudentListDataModel]()
    
    func objectMapping(json: JSON) {
        subject_name = json["data"]["detail_school_create_exercise"]["subject_name"].stringValue
        for data in json["data"]["detail_school_create_exercise"]["list_student"].arrayValue {
            let d = CoordinatorDetailExerciseSchoolCreateStudentListDataModel()
            d.objectMapping(json: data)
            list_student.append(d)
        }
    }
}

class CoordinatorDetailExerciseSchoolCreateStudentListDataModel: NSObject {
    var child_id = ""
    var child_name = ""
    var child_image = ""
    var child_nis = ""
    var school_class = ""
    var start_time = ""
    var score = 0
    
    func objectMapping(json: JSON) {
        child_id = json["child_id"].stringValue
        child_name = json["child_name"].stringValue
        child_image = json["child_image"].stringValue
        child_nis = json["child_nis"].stringValue
        school_class = json["school_class"].stringValue
        start_time = json["start_time"].stringValue
        score = json["score"].intValue
    }
}

class CoordinatorExerciseStudentDoExerciseModel: NSObject {
    var date = ""
    var student_list = [CoordinatorExerciseStudentDoExerciseListModel]()
    
    func objectMapping(json: JSON) {
        date = json["data"]["date"].stringValue
        for data in json["data"]["student_list"].arrayValue {
            let d = CoordinatorExerciseStudentDoExerciseListModel()
            d.objectMapping(json: data)
            student_list.append(d)
        }
    }
}

class CoordinatorExerciseStudentDoExerciseListModel: NSObject {
    var child_id = ""
    var child_name = ""
    var child_image = ""
    var child_nis = ""
    var school_class = ""
    var exercise_name = ""
    var score = 0
    
    func objectMapping(json: JSON) {
        child_id = json["child_id"].stringValue
        child_name = json["child_name"].stringValue
        child_image = json["child_image"].stringValue
        child_nis = json["child_nis"].stringValue
        school_class = json["school_class"].stringValue
        exercise_name = json["exercise_name"].stringValue
        score = json["score"].intValue
    }
}

class DashboardCoordinatorSchooListModel: NSObject {
    var school_grade_id = ""
    var school_grade = ""
    var list = [DashboardCoordinatorSchoolListDataModel]()
    
    func objectMapping(json: JSON) {
        school_grade_id = json["school_grade_id"].stringValue
        school_grade = json["school_grade"].stringValue
        for data in json["list"].arrayValue {
            let d = DashboardCoordinatorSchoolListDataModel()
            d.objectMapping(json: data)
            list.append(d)
        }
    }
}

class DashboardCoordinatorSchoolListDataModel: NSObject {
    var school_id = ""
    var school_name = ""
    var school_image = ""
    var status = 0
    
    func objectMapping(json: JSON) {
        school_id = json["school_id"].stringValue
        school_name = json["school_name"].stringValue
        school_image = json["school_image"].stringValue
        status = json["status"].intValue
    }
}
