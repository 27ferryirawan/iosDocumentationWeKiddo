//
//  OthersViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 11/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class OthersViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Others", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Others", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        collectionView.register(UINib(nibName: "OtherCollectionCell", bundle: nil), forCellWithReuseIdentifier: "otherCollectionCell")
        collectionView.register(UINib(nibName: "AdministrationCell", bundle: nil), forCellWithReuseIdentifier: "administrationCollectionCell")
        collectionView.register(UINib(nibName: "OthersCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "othersCollectionReusableView")
    }
    func fetchProfileData() {
        ACRequest.POST_TEACHER_PROFILE(userId: ACData.LOGINDATA.userID, schoolID: ACData.LOGINDATA.school_id, role: ACData.LOGINDATA.role, yearID: ACData.LOGINDATA.year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (profileData) in
            ACData.PARENTPROFILEDATA = profileData
            SVProgressHUD.dismiss()
            let profileVC = ParentProfileViewController()
            profileVC.subjectCount = ACData.PARENTPROFILEDATA.subject_class.count
            self.navigationController?.pushViewController(profileVC, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
        }
    }
}
extension OthersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func indexTitles(for collectionView: UICollectionView) -> [String]? {
        return ["Administration", "Others"]
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "othersCollectionReusableView", for: indexPath) as? OthersCollectionReusableView{
            if indexPath.section == 0 {
                sectionHeader.sectionHeaderLabel.text = "Administration"
            } else {
                sectionHeader.sectionHeaderLabel.text = "Others"
            }

            return sectionHeader
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return ACData.LOGINDATA.dashboardCategoryFeature.count
        } else {
            return ACData.LOGINDATA.dashboardCatgoryOthers.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "otherCollectionCell", for: indexPath) as? OtherCollectionCell)!
            cell.configCell(index: indexPath.row)
            return cell
        } else {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "administrationCollectionCell", for: indexPath) as? AdministrationCell)!
            cell.detailObj = ACData.LOGINDATA.dashboardCatgoryOthers[indexPath.row]
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("section -> \(indexPath.section) at Row -> \(indexPath.row)")
        
        if indexPath.section == 0 {
            let menu = ACData.LOGINDATA.dashboardCategoryFeature[indexPath.row].menu_id
            switch menu {
            case "34":
                let announcementVC = AnnouncementViewController()
                self.navigationController?.pushViewController(announcementVC, animated: true)
            case "42":
                let latePaymentVC = LatePaymentViewController()
                self.navigationController?.pushViewController(latePaymentVC, animated: true)
            case "36":
                let attendanceVC = AttendancesViewController()
                self.navigationController?.pushViewController(attendanceVC, animated: true)
            case "50":
                let teacherDutyVC = TeacherOnDutyViewController()
                self.navigationController?.pushViewController(teacherDutyVC, animated: true)
            case "37":
//                let latePaymentVC = LatePaymentViewController()
//                self.navigationController?.pushViewController(latePaymentVC, animated: true)
//                let teacherOnDutyVC = TeacherOnDutyViewController()
//                self.navigationController?.pushViewController(teacherOnDutyVC, animated: true)
                let subjectVC = SubjectTeacherViewController()
                self.navigationController?.pushViewController(subjectVC, animated: true)
//                let permissionVC = PermissionViewController()
//                self.navigationController?.pushViewController(permissionVC, animated: true)
//                let examScheduleVC = ExamViewController()
//                self.navigationController?.pushViewController(examScheduleVC, animated: true)

            case "38":
                let detentionVC = DetentionViewController()
                self.navigationController?.pushViewController(detentionVC, animated: true)
            case "41":
                let examVC = ExamViewController()
                self.navigationController?.pushViewController(examVC, animated: true)
            case "43":
                let assignmentVC = AssignmentViewController()
                self.navigationController?.pushViewController(assignmentVC, animated: true)
//                let teacherOnDutyVC = TeacherOnDutyViewController()
//                self.navigationController?.pushViewController(teacherOnDutyVC, animated: true)
//                let assignmentVC = AssignmentViewController()
//                self.navigationController?.pushViewController(assignmentVC, animated: true)
//                let assignmentVC = AssignmentViewController()
//                self.navigationController?.pushViewController(assignmentVC, animated: true)

            case "35":
                let eventVC = AdminEventListViewController()
                self.navigationController?.pushViewController(eventVC, animated: true)
            case "47":
                let subjectVC = SubjectTeacherViewController()
                self.navigationController?.pushViewController(subjectVC, animated: true)
            case "51" : self.tabBarController?.selectedIndex = 0
            default:
                self.tabBarController?.selectedIndex = 0
            }
        } else {
            let menu = ACData.LOGINDATA.dashboardCatgoryOthers[indexPath.row].menu_id
            switch menu {
            case "54":
                fetchProfileData()
            case "57":
                let feedbackVC = FeedbackViewController()
                self.navigationController?.pushViewController(feedbackVC, animated: true)
            case "55":
                UserDefaults.standard.set(false, forKey: "isLogin")
                UserDefaults.standard.synchronize()
                let mainViewController = ViewController()
                let navController = UINavigationController(rootViewController: mainViewController)
                UIApplication.shared.keyWindow?.rootViewController = navController
            default:
                return
            }
        }
    }
}

/*
extension OthersViewController: FeaturedDelegate, OthersDelegate, SettingsDelegate {
    func goToChangeLanguage() {
        
    }
    func goToParentProfile() {
        let parentProfileVC = ParentProfileViewController()
        self.navigationController?.pushViewController(parentProfileVC, animated: true)
    }
    func goToStudentProfile() {
        let studentProfileVC = StudentProfileViewController()
        self.navigationController?.pushViewController(studentProfileVC, animated: true)
    }
    func goToLogOut() {
        ACData.EXAMDATA.removeAll()
        ACData.ANNOUNCEMENT.removeAll()
        ACData.ASSIGNMENT.removeAll()
        ACData.SESSIONS.removeAll()
        ACData.COURSELISTDATA.removeAll()
        ACData.NEWSCONTENT.removeAll()
        ACData.TABBARMENUDATA.removeAll()
        ACData.CHILDCONTENT.removeAll()
        ACData.MENUCATEGORYOTHERSDATA.removeAll()
        ACData.MENUCATEGORYFEATUREDATA.removeAll()
        ACData.MENUCATEGORYSETTINGDATA.removeAll()
        let mainViewController = ViewController()
        let navController = UINavigationController(rootViewController: mainViewController)
        UIApplication.shared.keyWindow?.rootViewController = navController
    }
    
    // OTHERS
    func goToSubject() {
        let subjectVC = SubjectListViewController()
        self.navigationController?.pushViewController(subjectVC, animated: true)
    }
    func goToParentChat() {
        
    }
    func goToAssignment() {
        let assignmentVC = AssignmentViewController()
        self.navigationController?.pushViewController(assignmentVC, animated: true)
    }
    func goToApproval() {
        let approvalVC = ApprovalViewController()
        self.navigationController?.pushViewController(approvalVC, animated: true)
    }
    func goToScore() {
        
    }
    func goToQuestion() {
        let questionVC = QuestionsViewController()
        self.navigationController?.pushViewController(questionVC, animated: true)
    }
    func goToPermission() {
        let permissionVC = PermissionViewController()
        self.navigationController?.pushViewController(permissionVC, animated: true)
    }
    func goToAnnouncement() {
        let announcementVC = AnnouncementViewController()
        self.navigationController?.pushViewController(announcementVC, animated: true)
    }
    func goToDownload() {
        
    }
    func goToTransaction() {
        
    }
    func goToNews() {
        let newsVC = NewsViewController()
        self.navigationController?.pushViewController(newsVC, animated: true)
    }
    
    func goToAgency() {
        let agencyVC = AgencyViewController()
        self.navigationController?.pushViewController(agencyVC, animated: true)
    }
    
    func goToFosterParent() {
        
    }
    
    func goToCalendar() {
        let calendarVC = CalendarViewController()
        self.navigationController?.pushViewController(calendarVC, animated: true)
    }
    
    
    // FEATURED
    func goToNearby() {
        let nearbyVC = NearbyViewController()
        self.navigationController?.pushViewController(nearbyVC, animated: true)
    }
    func goToFuture() {
        let futureVC = FuturePlanViewController()
        self.navigationController?.pushViewController(futureVC, animated: true)
    }
    func goToCompetition() {
        let competitionVC = CompetitionViewController()
        self.navigationController?.pushViewController(competitionVC, animated: true)
    }
    func goToMedical() {
        let medicalVC = MedicalRecordViewController()
        self.navigationController?.pushViewController(medicalVC, animated: true)
    }
}
*/
