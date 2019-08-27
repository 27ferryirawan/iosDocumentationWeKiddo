//
//  SessionDetailViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 06/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class SessionDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Session Detail", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Session", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "SessionDetailCell", bundle: nil), forCellReuseIdentifier: "sessionDetailCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension SessionDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 583
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "sessionDetailCell", for: indexPath) as? SessionDetailCell)!
        cell.config()
        cell.delegate = self
        return cell
    }
}

extension SessionDetailViewController: SessionDetailCellDelegate {
    func toStudentNote() {
        guard let obj = ACData.SESSIONDETAIL else {
            return
        }
        let studentVC = StudentsNoteViewController()
        studentVC.chapterID = obj.chapter_id
        self.navigationController?.pushViewController(studentVC, animated: true)
    }
}
