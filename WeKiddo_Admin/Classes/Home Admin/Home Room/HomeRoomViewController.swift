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
    
    @IBOutlet weak var grayAreaBtn: UIButton!{
        didSet{
            grayAreaBtn.isHidden = true
            grayAreaBtn.backgroundColor = UIColor(displayP3Red: 102/255, green: 102/255, blue: 102/255, alpha: 0.8)
        }
    }
    enum HomeRoomSection {
        case header
        case upcomingSession(UpComingType)
        case homeButton(HomeButtonType)
        case dashboardDetention
        case dashboardSpecialAttentionClass
        case dashboardSpecialAttentionSubject
        case dashboardPermissionRequest
        case dashboardAssignment
        case dashboardCurrentClassSession
        case footer
        case currentClassSubject
        
        enum UpComingType {
            case assignment
            case permission
            case specialAttentionByClass
            case specialAttentionBySubject
            case detention
        }
        
        enum HomeButtonType {
            case assignment
            case permission
            case currentClass
            case specialAttentionByClass
            case specialAttentionBySubject
            case detention
        }
    }
    
    @IBOutlet weak var closeDetentionButton: UIButton!
    @IBOutlet weak var detentionReason: UILabel!
    @IBOutlet weak var detentionView: UIView! {
        didSet {
            detentionView.setBorderShadow(color: .lightGray, shadowRadius: 2.0, shadowOpactiy: 1.0, shadowOffsetWidth: 2, shadowOffsetHeight: 2)
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
        updateView()
        grayAreaBtn.addTarget(self, action: #selector(displayGrayArea), for: .touchUpInside)
    }
    
    @objc func displayGrayArea(){
        grayAreaBtn.isHidden = true
        detentionView.isHidden = true
        isDetentionViewDisplayed = true
    }
    
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Dashboard", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
    }
    
    func configTable() {
        closeDetentionButton.addTarget(self, action: #selector(closeDetentionView), for: .touchUpInside)
        tableView.register(UINib(nibName: "HomeRoomHeaderCell", bundle: nil), forCellReuseIdentifier: "homeRoomHeaderCellID")
        tableView.register(UINib(nibName: "HomeRoomUpcomingSessionSectionCell", bundle: nil), forCellReuseIdentifier: "homeRoomUpcomingSessionSectionCellID")
        tableView.register(UINib(nibName: "HomeButtonCell", bundle: nil), forCellReuseIdentifier: "homeButtonCellID")
        tableView.register(UINib(nibName: "HomeRoomDueDateAssignmentCell", bundle: nil), forCellReuseIdentifier: "homeRoomDueDateAssignmentCellID")
        tableView.register(UINib(nibName: "HomeRoomPermissionRequestCell", bundle: nil), forCellReuseIdentifier: "homeRoomPermissionRequestCellID")
        tableView.register(UINib(nibName: "HomeRoomCurrentClassSubjectCell", bundle: nil), forCellReuseIdentifier: "homeRoomCurrentClassSubjectCellID")
        tableView.register(UINib(nibName: "HomeRoomCurrentClassStudentCell", bundle: nil), forCellReuseIdentifier: "homeRoomCurrentClassStudentCellID")
        tableView.register(UINib(nibName: "HomeRoomSpecialAttentionCell", bundle: nil), forCellReuseIdentifier: "homeRoomSpecialAttentionCellID")
        tableView.register(UINib(nibName: "HomeRoomDetentionCell", bundle: nil), forCellReuseIdentifier: "homeRoomDetentionCellID")
        tableView.register(UINib(nibName: "FooterContentCell", bundle: nil), forCellReuseIdentifier: "footerContentCell")
    }
    @objc func closeDetentionView() {
        isDetentionViewDisplayed = false
        updateView()
    }
}

extension HomeRoomViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .header, .upcomingSession, .homeButton, .footer, .currentClassSubject:
            return 1
        case .dashboardDetention:
            return ACData.DASHBOARDDATA.dashboardDetention.count
        case .dashboardPermissionRequest:
            return ACData.DASHBOARDDATA.dashboardPermissionRequest.count
        case .dashboardSpecialAttentionClass:
            return ACData.DASHBOARDDATA.dashboardSpecialAttentionClass.count
        case .dashboardAssignment:
            return ACData.DASHBOARDDATA.dashboardAssignment.count
        case .dashboardCurrentClassSession:
            return ACData.DASHBOARDDATA.dashboarCurrentClassSession.count
        case .dashboardSpecialAttentionSubject:
            return ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section] {
        case .header:
            return 291
        case .upcomingSession:
            return 33
        case .dashboardDetention, .dashboardSpecialAttentionClass, .dashboardCurrentClassSession, .dashboardSpecialAttentionSubject:
            return 88
        case .dashboardPermissionRequest, .dashboardAssignment:
            return 66
        case .homeButton:
            return 55
        case .footer:
            return 228
        case .currentClassSubject:
            return 85
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
            
            var isAssignment = false
            var isPermission = false
            var isSpecialAttentionByClass = false
            var isSpecialAttentionBySubject = false
            var isDetention = false
            
            switch type {
            case .assignment:
                isAssignment = true
            case .detention:
                isDetention = true
            case .permission:
                isPermission = true
            case .specialAttentionByClass:
                isSpecialAttentionByClass = true
            case .specialAttentionBySubject:
                isSpecialAttentionBySubject = true
            }
            
            cell.config(
                isAssignment: isAssignment,
                isPermission: isPermission,
                isSpecialAttentionByClass: isSpecialAttentionByClass,
                isSpecialAttentionBySubject: isSpecialAttentionBySubject,
                isDetention: isDetention
            )
            return cell
        case .dashboardSpecialAttentionClass:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomSpecialAttentionCellID", for: indexPath) as? HomeRoomSpecialAttentionCell)!
            cell.detailClassObj = ACData.DASHBOARDDATA.dashboardSpecialAttentionClass[indexPath.row]
            cell.delegate = self
            return cell
        case .dashboardSpecialAttentionSubject:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomSpecialAttentionCellID", for: indexPath) as? HomeRoomSpecialAttentionCell)!
            cell.detailSubjectObj = ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject[indexPath.row]
            cell.delegate = self
            return cell
        case .dashboardPermissionRequest:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomPermissionRequestCellID", for: indexPath) as? HomeRoomPermissionRequestCell)!
            cell.permissionObj = ACData.DASHBOARDDATA.dashboardPermissionRequest[indexPath.row]
            cell.delegate = self
            return cell
        case .dashboardAssignment:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomDueDateAssignmentCellID", for: indexPath) as? HomeRoomDueDateAssignmentCell)!
            cell.assignObj = ACData.DASHBOARDDATA.dashboardAssignment[indexPath.row]
            cell.delegate = self
            return cell
        case .dashboardDetention:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomDetentionCellID", for: indexPath) as? HomeRoomDetentionCell)!
            cell.detentObj = ACData.DASHBOARDDATA.dashboardDetention[indexPath.row]
            cell.delegate = self
            return cell
        case .dashboardCurrentClassSession:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomCurrentClassStudentCellID", for: indexPath) as? HomeRoomCurrentClassStudentCell)!
            cell.studentObj = ACData.DASHBOARDDATA.dashboarCurrentClassSession[indexPath.row]
            return cell
        case .currentClassSubject:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "homeRoomCurrentClassSubjectCellID", for: indexPath) as? HomeRoomCurrentClassSubjectCell)!
            cell.currentObj = ACData.DASHBOARDDATA
            return cell
        case .homeButton(let type):
            let cell = (tableView.dequeueReusableCell(withIdentifier: "homeButtonCellID", for: indexPath) as? HomeButtonCell)!
            
            var isAssignment = false
            var isPermission = false
            var isSpecialAttentionByClass = false
            var isSpecialAttentionBySubject = false
            var isDetention = false
            var isCurrentClass = false
            
            switch type {
            case .assignment:
                isAssignment = true
                cell.buttonSection.tag = 0
            case .detention:
                isDetention = true
                cell.buttonSection.tag = 5
            case .permission:
                isPermission = true
                cell.buttonSection.tag = 1
            case .specialAttentionByClass:
                isSpecialAttentionByClass = true
                cell.buttonSection.tag = 4
            case .specialAttentionBySubject:
                isSpecialAttentionBySubject = true
                cell.buttonSection.tag = 3
            case .currentClass:
                isCurrentClass = true
                cell.buttonSection.tag = 2
            }
            
            cell.cellHomeroomConfig(
                isAssignment: isAssignment,
                isPermission: isPermission,
                isCurrentClass: isCurrentClass,
                isSpecialAttentionByClass: isSpecialAttentionByClass,
                isSpecialAttentionBySubject: isSpecialAttentionBySubject,
                isDetention: isDetention
            )
            cell.buttonSection.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
            cell.delegate = self
            return cell
        case .footer:
            let cell = (tableView.dequeueReusableCell(withIdentifier: "footerContentCell", for: indexPath) as? FooterContentCell)!
            cell.delegate = self
            return cell
        }
    }
}

extension HomeRoomViewController: HomeButtonCellDelegate, HomeRoomDueDateAssignmentCellDelegate, HomeRoomPermissionRequestCellDelegate, HomeRoomHeaderCellDelegate, FooterHomeDelegate, HomeRoomSpecialAttentionCellDelegate, HomeRoomDetentionCellDelegate {
    func showDetentionReason(withReason: String) {
        reason = withReason
        isDetentionViewDisplayed = true
        updateView()
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
    func toLatePaymentList() {
        
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
    func toSessionDetail() {
        
    }
    func toEventList() {
        
    }
    func toAssignmentList() {
    }
    func toPermissionList() {
    }
    func toDetentionList() {
        let detentionVC = DetentionViewController()
        self.navigationController?.pushViewController(detentionVC, animated: true)
    }
    func toDetailAssignment() {
        let assignmentDetailVC = AssignmentDetailViewController()
        self.navigationController?.pushViewController(assignmentDetailVC, animated: true)
    }
    func toDetailPermission() {
        let permissionDetailVC = PermissionRequestDetailViewController()
        self.navigationController?.pushViewController(permissionDetailVC, animated: true)
    }
    func toSeeMoreSession() {
        let upcomingListVC = UpcomingSessionListViewController()
        self.navigationController?.pushViewController(upcomingListVC, animated: true)
    }
    func toSpecialAttentionList() {
        //TODO: DIRECT TO SPECIAL ATTENTION VIEWCONTROLLER
    }
    func toCurrentClassList() {
    }
    @objc func toDetail(sender: UIButton) {
        if sender.tag == 0 {
            let assignmentVC = AssignmentViewController()
            //        assignmentVC.assignmentListCount = ACData.ASSIGNMENTLIST.assignmentList.count
            self.navigationController?.pushViewController(assignmentVC, animated: true)
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
        } else if sender.tag == 3 {
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
        } else if sender.tag == 4 {
            ACData.SPECIALATTENTIONBYCLASSDATA.removeAll()
            ACRequest.POST_TEACHER_SPECIAL_ATTENTION_BY_CLASS(userId: ACData.LOGINDATA.userID, schoolID: ACData.LOGINDATA.school_id, role: ACData.LOGINDATA.role, yearID: ACData.LOGINDATA.year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
                SVProgressHUD.dismiss()
                ACData.SPECIALATTENTIONBYCLASSDATA = jsonDatas
                let specialAttentionVC = SpecialAttentionListViewController()
                specialAttentionVC.isClass = true
                self.navigationController?.pushViewController(specialAttentionVC, animated: true)
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        } else if sender.tag == 5 {
            let detentionVC = DetentionViewController()
            self.navigationController?.pushViewController(detentionVC, animated: true)
        }
    }
}

private extension HomeRoomViewController {
    func configureSections() {
        sections.append(.header)
        if !ACData.DASHBOARDDATA.dashboardAssignment.isEmpty {
            sections.append(.upcomingSession(.assignment))
            sections.append(.dashboardAssignment)
            sections.append(.homeButton(.assignment))
        }
        if !ACData.DASHBOARDDATA.dashboardPermissionRequest.isEmpty {
            sections.append(.upcomingSession(.permission))
            sections.append(.dashboardPermissionRequest)
            sections.append(.homeButton(.permission))
        }
        if !ACData.DASHBOARDDATA.dashboarCurrentClassSession.isEmpty {
            sections.append(.currentClassSubject)
            sections.append(.dashboardPermissionRequest)
            sections.append(.homeButton(.currentClass))
        }
        if !ACData.DASHBOARDDATA.dashboardSpecialAttentionClass.isEmpty {
            sections.append(.upcomingSession(.specialAttentionByClass))
            sections.append(.dashboardSpecialAttentionClass)
            sections.append(.homeButton(.specialAttentionByClass))
        }
        if !ACData.DASHBOARDDATA.dashboardSpecialAttentionSubject.isEmpty {
            sections.append(.upcomingSession(.specialAttentionBySubject))
            sections.append(.dashboardSpecialAttentionSubject)
            sections.append(.homeButton(.specialAttentionBySubject))
        }
        if !ACData.DASHBOARDDATA.dashboardDetention.isEmpty {
            sections.append(.upcomingSession(.detention))
            sections.append(.dashboardDetention)
            sections.append(.homeButton(.detention))
        }
        sections.append(.footer)
    }
    func updateView() {
        if isDetentionViewDisplayed {
            grayAreaBtn.isHidden = false
            detentionView.isHidden = false
            isDetentionViewDisplayed = false
            detentionReason.text = reason
        } else {
            grayAreaBtn.isHidden = true
            detentionView.isHidden = true
            isDetentionViewDisplayed = true
        }
    }
}
