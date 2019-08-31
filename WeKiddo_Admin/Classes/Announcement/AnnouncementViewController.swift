//
//  AnnouncementViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 21/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class AnnouncementViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        fetchData()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Announcement", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Announcement", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "AnnouncementAllCell", bundle: nil), forCellReuseIdentifier: "announcementAllCell")
        tableView.register(UINib(nibName: "AnnouncementSubjectCell", bundle: nil), forCellReuseIdentifier: "announcementSubjectCell")
        tableView.register(UINib(nibName: "AnnouncementAddNewButtonCell", bundle: nil), forCellReuseIdentifier: "announcementAddNewButtonCellID")
    }
    func fetchData() {
        ACData.ANNOUNCEMENTLISTDATA.removeAll()
        ACRequest.GET_ANNOUNCEMENT_DATA(
            userID: ACData.LOGINDATA.userID,
            schoolID: ACData.LOGINDATA.dashboardSchoolMenu.last?.school_id ?? "",
            yearID: ACData.LOGINDATA.dashboardSchoolMenu.last?.year_id ?? "",
            accessToken: ACData.LOGINDATA.accessToken, successCompletion: { (announcementDatas) in
            SVProgressHUD.dismiss()
            ACData.ANNOUNCEMENTLISTDATA = announcementDatas
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension AnnouncementViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + ACData.ANNOUNCEMENTLISTDATA.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 25
        } else if indexPath.row == ACData.ANNOUNCEMENTLISTDATA.count + 1 {
            return 55
        } else {
            return 66
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "announcementAllCell", for: indexPath) as? AnnouncementAllCell)!
            return cell
        } else if indexPath.row == ACData.ANNOUNCEMENTLISTDATA.count + 1 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "announcementAddNewButtonCellID", for: indexPath) as? AnnouncementAddNewButtonCell)!
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "announcementSubjectCell", for: indexPath) as? AnnouncementSubjectCell)!
            cell.delegate = self
            cell.announcementObjc = ACData.ANNOUNCEMENTLISTDATA[indexPath.row-1]
            return cell
        }
    }
}

extension AnnouncementViewController: AnnouncementSubjectDelegate, AnnouncementAddNewButtonCellDelegate {
    func goToAnnouncementDetail() {
        let detailVC = AnnouncementDetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    func goToApprovalDetail() {
        // TODO: to approval detail page
    }
    func toAddAnnouncementPage() {
        let addAnnouncementVC = AddAnnouncementViewController()
        addAnnouncementVC.isFromEdit = false
        self.navigationController?.pushViewController(addAnnouncementVC, animated: true)
    }
}
