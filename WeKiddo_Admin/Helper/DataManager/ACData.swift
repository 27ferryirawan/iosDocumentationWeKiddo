//
//  ACData.swift
//  AYO CLEAN
//
//  Created by Zein Rezky Chandra on 28/05/18.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

struct ACData {
    static var LOGINDATA: LoginModel!
    static var DASHBOARDDATA: DashboardModel!
    static var USER: UserModel!    
    static var HOMEDATA: HomeGeneralDataModel!
    static var CURRENTSESSIONDATA: CurrentSessionModel!
    static var ANNOUNCEMENTDETAILDATA: AnnouncementDetail!
    static var ANNOUNCEMENTEDITDETAILDATA: AnnouncementEditDetail!
    static var NEWSCONTENT = [NewsModel]()
    static var PARENTNEWSCONTENT = [ParentNewsModel]()
    static var CHILDCONTENT = [ChildModel]()
    static var APPROVAL = [ApprovalModel]()
    static var APPROVALDETAILDATA: ApprovalDetailModel!
    static var ANNOUNCEMENT = [AnnouncementModel]()
    static var ANNOUNCEMENTLISTDATA = [AnnouncementListModel]()
    static var ANNOUNCEMENTLEVELLISTDATA = [AnnouncementLevelListModel]()
    static var AGENCY = [AgencyModel]()
    static var MEDICAL = [MedicalModel]()
    static var MOREMENU = [MoreMenuModel]()
    static var ASSIGNMENT = [AssignmentModel]()
    static var ASSIGNMENTLIST: AssignmentListModel!
    static var ASSIGNMENTTEACHERLIST : AssignmentTeacherListModel!
    static var ASSIGNMENTTEACHERLISTALL : AssignmentTeacherListAllModel!
    static var ASSIGNMENTSUBJECTLIST : AssignmentSubjectListModel!
    static var ASSIGNMENTCHAPTERLIST : AssignmentChapterListModel!
    static var ASSIGNMENTMODULMODEL = [AssignmentModulModel]()
    static var SESSIONS = [SessionsModel]()
    static var SESSIONDETAIL: SessionDetailModel!
    static var TABBARMENUDATA = [TabbarsMenuModel]()
    static var MENUCATEGORYFEATUREDATA = [MenuCategoryFeaturesModel]()
    static var MENUCATEGORYOTHERSDATA = [MenuCategoryOthersModel]()
    static var MENUCATEGORYSETTINGDATA = [MenuCategorySettingModel]()
    static var TOKEN = ""
    static var ANNOUNCEMENTMEDIA = [AnnouncementMediaModel]()
    static var PERMISSIONDATA: PermissionModel!
    static var PERMISSIONDETAILDATA: PermissionDataModel!
    static var COMPETITIONDATA = [CompetitionModel]()
    static var COMPETITIONCATEGORYDATA = [CompetitionCategoryModel]()
    static var NEARBYDATA = [NearbyModel]()
    static var CALENDARDATA: CalendarModel!
    static var FUTUREPLANACADEMYDATA = [FuturePlanAcademyModel]()
    static var FUTUREPLANTALENTDATA = [FuturePlanTalentModel]()
    static var FUTUREPLANCAREERDATA = [FuturePlanCareerModel]()
    static var CAREERDETAILDATA: CareerDetailModel!
    static var UNIVERSITYDATA = [UniversityModel]()
    static var UNIVERSITYDETAILDATA: UniversityDetailModel!
    static var COMPETITIONDETAILDATA: CompetitionDetailModel!
    static var COURSEDETAILDATA: CourseDetailModel!
    static var ATTENDANCEDATA = [AttendanceModel]()
    static var ATTENDANCEDETAILDATA: AttendanceDetailModel!
    static var NEARBYCOURSEMOREDATA = [NearbyCourseMoreModel]()
    static var LOGININFODATA = [SchoolModel]()
    static var COURSELISTDATA = [CourseListModel]()
    static var SCHOOLDATA = [SchoolModel]()
    static var SCHOOLDETAILDATA: SchoolDetailModel!
    static var ASSIGNMENTDETAILDATA: AssignmentDetailModel!
    static var ASSIGNMENTDETAILEDITDATA: AssignmentDetailEditModel!
    static var NOTIFICATIONDATA = [NotificationModel]()
    static var CALENDARAGENDALISTDATA = [CalendarAgendaModel]()
    static var EXAMDATA = [ExamsModel]()
    static var EXAMLISTDATA: ExamListDataModel!
    static var EXAMDETAILDATA: ExamDetailModel!
    static var EXAMTEACHERLISTALL : ExamTeacherListAll!
    static var EXAMTEACHERLIST: ExamTeacherList!
    static var EXAMLISTADMIN : ExamListModel!
    static var EXAMSUBJECTLIST : ExamSubjectListModel!
    static var EXAMLEVELLIST : ExamLevelListModel!
    static var SCOREDATA = [ScoreModel]()
    static var SCORESUMMARYDATA = [ScoreSummaryModel]()
    static var PARENTPROFILEDATA: ParentProfileModel!
    static var SUBJECTLISTDATA = [SubjectListModel]()
    static var STUDENTNOTEDATA: StudentNoteModel!
    static var ATTACHMENTDATA: AttachmentModel!
    static var SUBJECTDETAILDATA: SubjectDetailModel!
    static var SEARCHDATA: SearchModel!
    static var SUBJECTDATA = [SubjectModel]()
    static var CHAPTERDATA: ChapterModel!
    static var SCORELISTDATA: ScoreListModel!
    static var DETENTIONDATA = [DetentionModel]()
    static var STUDENTSEARCHDATA = [StudentSearchModel]()
    static var ATTACHMENTBANNERDATA = [AttachmentBannerModel]()
    static var ATTACHMENTIMAGEMEDIADATA = [AttachmentImageMediaModel]()
    static var ATTACHMENTVIDEOMEDIADATA = [AttachmentVideoMediaModel]()
    static var ANNOUNCEMENTCLASSDATA = [AnnouncementClassDataModel]()
    static var TEACHERONDUTYGETLISTDATA: TeacherOnDutyChildListModel!
    static var UPCOMINGSESSIONLISTDATA = [UpcomingSessionListModel]()
    static var ADMINEVENTLISTDATA = [AdminEventListModel]()
    static var LATEPAYMENTLISTDATA = [LatePaymentListModel]()
    static var LATEPAYMENTDETAILDATA: LatePaymentDetailModel!
    static var SUBJECTTEACHERBYSUBJECT = [SubjectTopicBySubjectModel]()
    static var SUBJECTTEACHERBYCLASS = [SubjectTopicByClassModel]()
    static var SUBJECTTEACHERCHAPTERLISTDATA: SubjectTeacherChapterListModel!
//    static var SUBJECTTEACHERCHAPTERLISTDATA = [SubjectTeacherChapterListModel]()
    static var TEACHERONDUTYPICKERDATA : TeacherOnDutyChildListPickerModel!
    static var SUBJECTTEACHERBYCLASSSESSIONLISTDATA: SubjectTeacherByClassSessionListModel!
    static var SUBJECTTEACHERPARAMMODEL: SubjectTeacherParamModel!
    static var SUBJECTTEACHERDATATACHMENTDATAMODEL = [SubjectTeacherAttachmentArrayModel]()
    static var SUBJECTTEACHERDATAVOICENOTEMODEL = [SubjectTeacherVoiceNotesArrayModel]()
    static var EXAMREMEDYSCORELISTDATA: ExamRemedyScoreListModel!
    static var EXAMEDITDATA: ExamEditModel!
    static var EXAMCLASSDATA: ExamMajorModel!
    static var EXAMSESSIONDATA: ExamMajorModel!
    static var EVENTCOUNTDATA: EventCountModel!
    static var SPECIALATTENTIONBYSUBJECTDATA = [SpecialAttentionBySubjectListModel]()
    static var SPECIALATTENTIONBYCLASSDATA = [SpecialAttentionByClassListModel]()
    static var CURRENTCLASSLISTDATA: CurrentClassListModel!
    static var SUBJECTTEACHERDETAILMODEL: SubjectTeacherDetailModel!
    static var SPECIALATTENTIONBYSUBJECTDETAILDATA: SpecialAttentionBySubjectDetailModel!
    static var SPECIALATTENTIONBYCLASSDETAILDATA: SpecialAttentionByClassDetailModel!
    static var ABSENCEDETAILMODEL: AbsenceDetailModel!
    static var TASKLISTDATA = [TaskListModel]()
    static var ABSENCELISTMODEL = [AbsenceListModel]()
    static var SCHOOLMONITORINGDATA: SchoolMonitoringModel!
    static var TOTALSTUDENTDATA = [TotalStudentModel]()
    static var TOTALPARENTDATA = [TotalParentModel]()
    static var TOTALTEACHERDATA = [TotalTeacherModel]()
    static var TASKLISTADMINNEWDATA = [TaskListAdminModel]()
    static var TASKLISTADMINHISTORYDATA = [TaskListAdminHistoryModel]()
    static var ADMINPROFILEDATA: AdminProfileModel!
    static var ADMINLISTDATA = [AdminListModel]()
    static var DETAILTASKADMINDATA: DetailTaskAdminModel!
    static var TICKETPENDINGDATA = [TicketPendingModel]()
    static var DETAILTICKETDATA: DetailTicketModel!
//    static var STUDENTLISTSCOREADDNEW: !
}
