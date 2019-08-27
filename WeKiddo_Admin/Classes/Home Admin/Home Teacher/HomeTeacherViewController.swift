//
//  HomeTeacherViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 17/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeTeacherViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        configTabMenu()
    }
    func configTabMenu() {
        
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Dashboard", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
    }
    func configTable() {
        table.register(UINib(nibName: "HomeRoomHeaderCell", bundle: nil), forCellReuseIdentifier: "homeRoomHeaderCellID")
        table.register(UINib(nibName: "HomeRoomUpcomingSessionSectionCell", bundle: nil), forCellReuseIdentifier: "homeRoomUpcomingSessionSectionCellID")
        table.register(UINib(nibName: "HomeButtonCell", bundle: nil), forCellReuseIdentifier: "homeButtonCellID")
        table.register(UINib(nibName: "HomeRoomDueDateAssignmentCell", bundle: nil), forCellReuseIdentifier: "homeRoomDueDateAssignmentCellID")
        table.register(UINib(nibName: "HomeRoomSpecialAttentionCell", bundle: nil), forCellReuseIdentifier: "homeRoomSpecialAttentionCellID")
        table.register(UINib(nibName: "FooterContentCell", bundle: nil), forCellReuseIdentifier: "footerContentCell")
        table.delegate = self
        table.dataSource = self
    }
}

extension HomeTeacherViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ACData.DASHBOARDDATA.dashboardAssignment.count != 0 && ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count != 0 {
            return 6 + ACData.DASHBOARDDATA.dashboardAssignment.count + ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count
        } else if ACData.DASHBOARDDATA.dashboardAssignment.count != 0 && ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count == 0 {
            return 4 + ACData.DASHBOARDDATA.dashboardAssignment.count
        } else if ACData.DASHBOARDDATA.dashboardAssignment.count == 0 && ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count != 0 {
            return 4 + ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count
        } else {
            return 2
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if ACData.DASHBOARDDATA.dashboardAssignment.count != 0 && ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count != 0 {
            if indexPath.row == 0 {
                return 291
            } else if indexPath.row == 1 {
                return 33
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardAssignment.count + 2 {
                return 66
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardAssignment.count + 2 {
                return 55
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardAssignment.count + 3 {
                return 33
            } else if indexPath.row > ACData.DASHBOARDDATA.dashboardAssignment.count + 3 && indexPath.row < ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count + ACData.DASHBOARDDATA.dashboardAssignment.count + 4 {
                return 66
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardAssignment.count + ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count + 4 {
                return 55
            } else {
                return 228
            }
        } else if ACData.DASHBOARDDATA.dashboardAssignment.count != 0 && ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count == 0 {
            if indexPath.row == 0 {
                return 291
            } else if indexPath.row == 1 {
                return 33
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardAssignment.count + 2 {
                return 66
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardAssignment.count + 2 {
                return 55
            } else {
                return 228
            }
        } else if ACData.DASHBOARDDATA.dashboardAssignment.count == 0 && ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count != 0 {
            if indexPath.row == 0 {
                return 291
            } else if indexPath.row == 1 {
                return 33
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count + 2 {
                return 66
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count + 2 {
                return 55
            } else {
                return 228
            }
        } else {
            if indexPath.row == 0 {
                return 291
            } else {
                return 228
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ACData.DASHBOARDDATA.dashboardAssignment.count != 0 && ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count != 0 {
            if indexPath.row == 0 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomHeaderCellID", for: indexPath) as? HomeRoomHeaderCell)!
                cell.detailObj = ACData.DASHBOARDDATA
                cell.delegate = self
                return cell
            } else if indexPath.row == 1 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomUpcomingSessionSectionCellID", for: indexPath) as? HomeRoomUpcomingSessionSectionCell)!
                return cell
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardAssignment.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomDueDateAssignmentCellID", for: indexPath) as? HomeRoomDueDateAssignmentCell)!
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardAssignment.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeButtonCellID", for: indexPath) as? HomeButtonCell)!
                cell.delegate = self
                cell.cellHomeroomConfig(isAssignment: true, isPermission: false, isCurrentClass: false, isSpecialAttentionByClass: false, isSpecialAttentionBySubject: false, isDetention: false)
                cell.buttonSection.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
                cell.buttonSection.tag = 0
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardAssignment.count + 3 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomUpcomingSessionSectionCellID", for: indexPath) as? HomeRoomUpcomingSessionSectionCell)!
                return cell
            } else if indexPath.row > ACData.DASHBOARDDATA.dashboardAssignment.count + 3 && indexPath.row < ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count + ACData.DASHBOARDDATA.dashboardAssignment.count + 4 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomSpecialAttentionCellID", for: indexPath) as? HomeRoomSpecialAttentionCell)!
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardAssignment.count + ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count + 4 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeButtonCellID", for: indexPath) as? HomeButtonCell)!
                cell.delegate = self
                cell.cellHomeroomConfig(isAssignment: false, isPermission: false, isCurrentClass: false, isSpecialAttentionByClass: false, isSpecialAttentionBySubject: true, isDetention: false)
                cell.buttonSection.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
                cell.buttonSection.tag = 1
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "footerContentCell", for: indexPath) as? FooterContentCell)!
                cell.delegate = self
                return cell
            }
        } else if ACData.DASHBOARDDATA.dashboardAssignment.count != 0 && ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count == 0 {
            if indexPath.row == 0 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomHeaderCellID", for: indexPath) as? HomeRoomHeaderCell)!
                cell.detailObj = ACData.DASHBOARDDATA
                cell.delegate = self
                return cell
            } else if indexPath.row == 1 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomUpcomingSessionSectionCellID", for: indexPath) as? HomeRoomUpcomingSessionSectionCell)!
                return cell
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardAssignment.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomDueDateAssignmentCellID", for: indexPath) as? HomeRoomDueDateAssignmentCell)!
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardAssignment.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeButtonCellID", for: indexPath) as? HomeButtonCell)!
                cell.delegate = self
                cell.cellHomeroomConfig(isAssignment: true, isPermission: false, isCurrentClass: false, isSpecialAttentionByClass: false, isSpecialAttentionBySubject: false, isDetention: false)
                cell.buttonSection.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
                cell.buttonSection.tag = 0
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "footerContentCell", for: indexPath) as? FooterContentCell)!
                cell.delegate = self
                return cell
            }
        } else if ACData.DASHBOARDDATA.dashboardAssignment.count == 0 && ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count != 0 {
            if indexPath.row == 0 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomHeaderCellID", for: indexPath) as? HomeRoomHeaderCell)!
                cell.detailObj = ACData.DASHBOARDDATA
                cell.delegate = self
                return cell
            } else if indexPath.row == 1 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomUpcomingSessionSectionCellID", for: indexPath) as? HomeRoomUpcomingSessionSectionCell)!
                return cell
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomSpecialAttentionCellID", for: indexPath) as? HomeRoomSpecialAttentionCell)!
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeButtonCellID", for: indexPath) as? HomeButtonCell)!
                cell.delegate = self
                cell.cellHomeroomConfig(isAssignment: false, isPermission: false, isCurrentClass: false, isSpecialAttentionByClass: false, isSpecialAttentionBySubject: true, isDetention: false)
                cell.buttonSection.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
                cell.buttonSection.tag = 1
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "footerContentCell", for: indexPath) as? FooterContentCell)!
                cell.delegate = self
                return cell
            }
        } else {
            if indexPath.row == 0 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomHeaderCellID", for: indexPath) as? HomeRoomHeaderCell)!
                cell.detailObj = ACData.DASHBOARDDATA
                cell.delegate = self
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "footerContentCell", for: indexPath) as? FooterContentCell)!
                cell.delegate = self
                return cell
            }
        }
    }
}

extension HomeTeacherViewController: HomeButtonCellDelegate, FooterHomeDelegate, HomeRoomHeaderCellDelegate {
    func toCurrentClassList() {
        
    }
    
    func toLatePaymentList() {
        
    }
    
    func toSessionDetail() {
        
    }
    
    func toSeeMoreSession() {
        let upcomingListVC = UpcomingSessionListViewController()
        self.navigationController?.pushViewController(upcomingListVC, animated: true)
    }
    
    func goToNews() {
        let newsVC = NewsViewController()
        self.navigationController?.pushViewController(newsVC, animated: true)
    }
    func goToNewsDetail(urlString: String?) {
        guard let newsURL = urlString else {
            return
        }
        let newsDetailVC = NewsDetailViewController()
        newsDetailVC.stringURL = newsURL
        self.navigationController?.pushViewController(newsDetailVC, animated: true)
    }
    func toAssignmentList() {
        let assignmentVC = AssignmentViewController()
        assignmentVC.assignmentListCount = ACData.ASSIGNMENTLIST.assignmentList.count
        self.navigationController?.pushViewController(assignmentVC, animated: true)
    }
    func toPermissionList() {
        let permissionVC = PermissionViewController()
        self.navigationController?.pushViewController(permissionVC, animated: true)
    }
    func toDetentionList() {
        let detentionVC = DetentionViewController()
        self.navigationController?.pushViewController(detentionVC, animated: true)
    }
    func toEventList() {
        
    }
    func toSpecialAttentionList() {
        // TODO: DIRECT TO SPECIAL ATTENTION VIEW CONTROLLER
    }
    @objc func toDetail(_ sender: UIButton) {
        if sender.tag == 0 {
            let assignmentVC = AssignmentViewController()
            //        assignmentVC.assignmentListCount = ACData.ASSIGNMENTLIST.assignmentList.count
            self.navigationController?.pushViewController(assignmentVC, animated: true)
        } else if sender.tag == 1 {
            ACData.SPECIALATTENTIONBYSUBJECTDATA.removeAll()
            ACRequest.POST_TEACHER_SPECIAL_ATTENTION_BY_SUBJECT(userId: ACData.LOGINDATA.userID, schoolID: ACData.LOGINDATA.school_id, role: ACData.LOGINDATA.role, yearID: ACData.LOGINDATA.year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
                SVProgressHUD.dismiss()
                ACData.SPECIALATTENTIONBYSUBJECTDATA = jsonDatas
                let specialAttentionVC = SpecialAttentionListViewController()
                specialAttentionVC.isClass = false
                self.navigationController?.pushViewController(specialAttentionVC, animated: true)
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        }
    }
}
