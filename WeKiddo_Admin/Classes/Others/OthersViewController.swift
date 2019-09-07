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
        ACRequest.POST_ADMIN_PROFILE(userId: ACData.LOGINDATA.userID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (data) in
            SVProgressHUD.dismiss()
            ACData.ADMINPROFILEDATA = data
            let profileVC = ParentProfileViewController()
            profileVC.subjectCount = ACData.ADMINPROFILEDATA.assignSchool.count
            self.navigationController?.pushViewController(profileVC, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
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
            case "72":
                let monitoringVC = SchoolMonitoringViewController()
                self.navigationController?.pushViewController(monitoringVC, animated: true)
            case "63":
                let tasklistAdminVC = TaskListAdminViewController()
                self.navigationController?.pushViewController(tasklistAdminVC, animated: true)
            case "36":
                let attendanceVC = AttendancesViewController()
                self.navigationController?.pushViewController(attendanceVC, animated: true)
            case "61":
                let ticketVC = TicketViewController()
                self.navigationController?.pushViewController(ticketVC, animated: true)
            case "58":
                ACRequest.POST_USERS_LISTS(userId: ACData.LOGINDATA.userID, keyword: "", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
                    ACData.USERSLISTSDATA = results
                    SVProgressHUD.dismiss()
                    let usersVC = UsersViewController()
                    self.navigationController?.pushViewController(usersVC, animated: true)
                }) { (message) in
                    SVProgressHUD.dismiss()
                    ACAlert.show(message: message)
                }
            case "59":
                ACRequest.POST_USER_SCHOOL_SCHOOL_LIST(userId: ACData.LOGINDATA.userID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (results) in
                    ACData.USERSCHOOLLISTDATA = results
                    SVProgressHUD.dismiss()
                    
                    ACRequest.POST_USER_SCHOOL_LIST(userId: ACData.LOGINDATA.userID, schoolID: ACData.USERSCHOOLLISTDATA[0].school_id, yearID: ACData.USERSCHOOLLISTDATA[0].year_id, keyword: "", tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
                        ACData.USERLISTDATA = result
                        SVProgressHUD.dismiss()
                        let userschoolVC = UserSchoolListViewController()
                        self.navigationController?.pushViewController(userschoolVC, animated: true)
                    }) { (message) in
                        SVProgressHUD.dismiss()
                        ACAlert.show(message: message)
                    }

                }) { (message) in
                    SVProgressHUD.dismiss()
                    ACAlert.show(message: message)
                }
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
            case "60":
                let classVC = ClassroomViewController()
                self.navigationController?.pushViewController(classVC, animated: true)
            case "51" : self.tabBarController?.selectedIndex = 0
            default:
                self.tabBarController?.selectedIndex = 0
            }
        } else {
            let menu = ACData.LOGINDATA.dashboardCatgoryOthers[indexPath.row].menu_id
            switch menu {
            case "66":
                fetchProfileData()
            case "57":
                let feedbackVC = FeedbackViewController()
                self.navigationController?.pushViewController(feedbackVC, animated: true)
            case "65":
                let historyVC = HistoryViewController()
                self.navigationController?.pushViewController(historyVC, animated: true)
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
