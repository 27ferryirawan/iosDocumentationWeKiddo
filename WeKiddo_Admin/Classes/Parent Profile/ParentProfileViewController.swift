//
//  ParentProfileViewController.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 08/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class ParentProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var subjectCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
        configTable()
        configNavigation()
    }
    func populateData() {
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Parent Profile", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Parent Profile", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "ParentProfileCell", bundle: nil), forCellReuseIdentifier: "parentProfileCellID")
        tableView.register(UINib(nibName: "ParentProfileSubjectAndClassCell", bundle: nil), forCellReuseIdentifier: "parentProfileSubjectAndClassCellID")
        tableView.register(UINib(nibName: "ParentProfileFooterCell", bundle: nil), forCellReuseIdentifier: "parentProfileFooterCellID")
    }
}

extension ParentProfileViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + subjectCount
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 470
        } else if indexPath.row == 1 + subjectCount {
            return 80
        } else {
            return 60
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "parentProfileCellID", for: indexPath) as? ParentProfileCell)!
            cell.detailObj = ACData.ADMINPROFILEDATA
            return cell
        } else if indexPath.row == 1 + subjectCount {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "parentProfileFooterCellID", for: indexPath) as? ParentProfileFooterCell)!
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "parentProfileSubjectAndClassCellID", for: indexPath) as? ParentProfileSubjectAndClassCell)!
            cell.detailObj = ACData.ADMINPROFILEDATA.assignSchool[indexPath.row - 1]
            return cell
        }
    }
}

extension ParentProfileViewController: ParentProfileFooterCellDelegate, EditProfileParentViewControllerDelegate {
    func changPass() {
        let changePassVC = ForgotViewController()
        changePassVC.isFromEdit = true
        self.navigationController?.pushViewController(changePassVC, animated: true)
    }
    func editProf() {
        let editVC = EditProfileParentViewController()
        editVC.delegate = self
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    func refreshData() {
        
    }
}
