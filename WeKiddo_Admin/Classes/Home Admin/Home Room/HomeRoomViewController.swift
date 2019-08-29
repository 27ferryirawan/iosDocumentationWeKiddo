//
//  HomeRoomViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 17/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeRoomViewController: UIViewController {
    
    enum HomeRoomSection {
        case header
        case upcomingSession(UpComingType)
        case homeButton(HomeButtonType)
        case dashboardTaskList
        case dashboardAbsentCheckList
        case dashboardSessionCheckList
        
        enum UpComingType {
            case taskList
            case absentCheckList
            case sessionCheckList
        }
        
        enum HomeButtonType {
            case taskList
            case absentCheckList
            case sessionCheckList
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    private var sections = [HomeRoomSection]()
    private var isDetentionViewDisplayed = false
    private var reason = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        configureSections()
    }
    
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Dashboard", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
    }
    
    func configTable() {
        tableView.register(UINib(nibName: "HomeRoomHeaderCell", bundle: nil), forCellReuseIdentifier: "homeRoomHeaderCellID")
        tableView.register(UINib(nibName: "HomeRoomUpcomingSessionSectionCell", bundle: nil), forCellReuseIdentifier: "homeRoomUpcomingSessionSectionCellID")
        tableView.register(UINib(nibName: "HomeButtonCell", bundle: nil), forCellReuseIdentifier: "homeButtonCellID")
        tableView.register(UINib(nibName: "HomeRoomDueDateAssignmentCell", bundle: nil), forCellReuseIdentifier: "homeRoomDueDateAssignmentCellID")
        tableView.register(UINib(nibName: "HomeRoomSpecialAttentionCell", bundle: nil), forCellReuseIdentifier: "homeRoomSpecialAttentionCellID")
        tableView.register(UINib(nibName: "HomeLatePaymentCell", bundle: nil), forCellReuseIdentifier: "homeLatePaymentCellID")
    }
}

extension HomeRoomViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .header, .upcomingSession, .homeButton:
            return 1
        case .dashboardTaskList:
            return ACData.DASHBOARDDATA.dashboardTaskList.count
        case .dashboardAbsentCheckList:
            return ACData.DASHBOARDDATA.dashboardAbsentCheckList.count
        case .dashboardSessionCheckList:
            return ACData.DASHBOARDDATA.dashboardSessionCheckList.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section] {
        case .header:
            return 195
        case .upcomingSession:
            return 33
        case .dashboardTaskList, .dashboardAbsentCheckList, .dashboardSessionCheckList:
            return 66
        case .homeButton:
            return 55
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .header:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomHeaderCellID", for: indexPath) as? HomeRoomHeaderCell)!
            cell.detailObj = ACData.DASHBOARDDATA
            cell.delegate = self
            return cell
        case .upcomingSession(let type):
            let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomUpcomingSessionSectionCellID", for: indexPath) as? HomeRoomUpcomingSessionSectionCell)!
            
            var isTaskList = false
            var isAbsentCheckList = false
            var isSessionCheckList = false
            
            switch type {
            case .taskList:
                isTaskList = true
            case .absentCheckList:
                isAbsentCheckList = true
            case .sessionCheckList:
                isSessionCheckList = true
            }
            
            cell.config(
                isTaskList: isTaskList,
                isAbsentCheckList: isAbsentCheckList,
                isSessionCheckList: isSessionCheckList
            )
            return cell
        case .dashboardTaskList:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomSpecialAttentionCellID", for: indexPath) as? HomeRoomSpecialAttentionCell)!
            cell.detailClassObj = ACData.DASHBOARDDATA.dashboardTaskList[indexPath.row]
            cell.delegate = self
            return cell
        case .dashboardSessionCheckList:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "homeLatePaymentCellID", for: indexPath) as? HomeLatePaymentCell)!
            return cell
        case .dashboardAbsentCheckList:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomDueDateAssignmentCellID", for: indexPath) as? HomeRoomDueDateAssignmentCell)!
            cell.assignObj = ACData.DASHBOARDDATA.dashboardAbsentCheckList[indexPath.row]
            cell.delegate = self
            return cell
        case .homeButton(let type):
            let cell = (tableView.dequeueReusableCell(withIdentifier: "homeButtonCellID", for: indexPath) as? HomeButtonCell)!
            
            var isTaskList = false
            var isAbsentCheckList = false
            var isSessionCheckList = false

            switch type {
            case .taskList:
                isTaskList = true
                cell.buttonSection.tag = 0
            case .absentCheckList:
                isAbsentCheckList = true
                cell.buttonSection.tag = 1
            case .sessionCheckList:
                isSessionCheckList = true
                cell.buttonSection.tag = 2
            }
            
            cell.cellHomeroomConfig(
                isTaskList: isTaskList,
                isAbsentCheckList: isAbsentCheckList,
                isSessionCheckList: isSessionCheckList
            )
            
            cell.buttonSection.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
            cell.delegate = self
            return cell
        }
    }
}

extension HomeRoomViewController: HomeButtonCellDelegate, HomeRoomDueDateAssignmentCellDelegate, HomeRoomHeaderCellDelegate, HomeRoomSpecialAttentionCellDelegate {
    func toTaskList() {
        
    }
    func toAbsentCheckList() {
        
    }
    func toSessionCheckList() {
        
    }
    func toDetailSpecialAttention(isClass: Bool) {
        print("isClass: \(isClass)")
        if isClass {
            let detailVC = SpecialAttentionDetailByClassViewController()
            detailVC.specialAttentionArray = ACData.SPECIALATTENTIONBYCLASSDETAILDATA.score_list.count
            self.navigationController?.pushViewController(detailVC, animated: true)
        } else {
            let detailVC = SpecialAttentionDetailViewController()
            detailVC.specialAttentionArray = ACData.SPECIALATTENTIONBYSUBJECTDETAILDATA.score_list.count
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    func toSessionDetail() {
        
    }
    func toSeeMoreSession() {
        
    }
    func refreshData() {
        self.tableView.reloadData()
    }
    func toDetailAssignment() {
        let assignmentDetailVC = AssignmentDetailViewController()
        self.navigationController?.pushViewController(assignmentDetailVC, animated: true)
    }
    @objc func toDetail(sender: UIButton) {
        if sender.tag == 0 {
            ACRequest.POST_TASKLIST_MORE(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (resultData) in
                SVProgressHUD.dismiss()
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        } else if sender.tag == 1 {
            let permissionVC = PermissionViewController()
            self.navigationController?.pushViewController(permissionVC, animated: true)
        } else if sender.tag == 2 {
            ACRequest.POST_CURRENT_SESSION_MORE(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, page: 1, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
                SVProgressHUD.dismiss()
                ACData.CURRENTCLASSLISTDATA = jsonDatas
                let currentClassVC = CurrentSessionListViewController()
                self.navigationController?.pushViewController(currentClassVC, animated: true)
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        }
    }
}

private extension HomeRoomViewController {
    func configureSections() {
        sections.append(.header)
        if !ACData.DASHBOARDDATA.dashboardTaskList.isEmpty {
            sections.append(.upcomingSession(.taskList))
            sections.append(.dashboardTaskList)
            sections.append(.homeButton(.taskList))
        }
        if !ACData.DASHBOARDDATA.dashboardAbsentCheckList.isEmpty {
            sections.append(.upcomingSession(.absentCheckList))
            sections.append(.dashboardAbsentCheckList)
            sections.append(.homeButton(.absentCheckList))
        }
        if !ACData.DASHBOARDDATA.dashboardSessionCheckList.isEmpty {
            sections.append(.upcomingSession(.sessionCheckList))
            sections.append(.dashboardSessionCheckList)
            sections.append(.homeButton(.sessionCheckList))
        }
    }
}
