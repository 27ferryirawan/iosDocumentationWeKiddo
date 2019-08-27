//
//  SpecialAttentionListViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 29/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class SpecialAttentionListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var specialAttentionArray = 0
    var isClass = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Special Attention", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        if isClass {
            specialAttentionArray = ACData.SPECIALATTENTIONBYCLASSDATA.count
        } else {
            specialAttentionArray = ACData.SPECIALATTENTIONBYSUBJECTDATA.count
        }

        tableView.register(UINib(nibName: "SpecialAttentionListCell", bundle: nil), forCellReuseIdentifier: "specialAttentionCellID")
    }
    @objc func toDetailSpecialAttentionByClass(_ sender: UIButton) {
        ACRequest.POST_SPECIAL_ATTENTION_DETAIL_BY_CLASS(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, classID: ACData.SPECIALATTENTIONBYCLASSDATA[sender.tag].school_class_id, childID: ACData.SPECIALATTENTIONBYCLASSDATA[sender.tag].child_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
            SVProgressHUD.dismiss()
            ACData.SPECIALATTENTIONBYCLASSDETAILDATA = jsonDatas
            let detailVC = SpecialAttentionDetailByClassViewController()
            detailVC.specialAttentionArray = ACData.SPECIALATTENTIONBYCLASSDETAILDATA.score_list.count
            self.navigationController?.pushViewController(detailVC, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    @objc func toDetailSpecialAttentionBySubject(_ sender: UIButton) {
        ACRequest.POST_SPECIAL_ATTENTION_DETAIL_BY_SUBJECT(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, subjectID: ACData.SPECIALATTENTIONBYSUBJECTDATA[sender.tag].subject_id, childID: ACData.SPECIALATTENTIONBYSUBJECTDATA[sender.tag].child_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
            SVProgressHUD.dismiss()
            ACData.SPECIALATTENTIONBYSUBJECTDETAILDATA = jsonDatas
            let detailVC = SpecialAttentionDetailViewController()
            detailVC.specialAttentionArray = ACData.SPECIALATTENTIONBYSUBJECTDETAILDATA.score_list.count
            self.navigationController?.pushViewController(detailVC, animated: true)
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension SpecialAttentionListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specialAttentionArray
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "specialAttentionCellID", for: indexPath) as? SpecialAttentionListCell)!
        cell.contentButton.tag = indexPath.row
        if isClass {
            cell.detailClassObj = ACData.SPECIALATTENTIONBYCLASSDATA[indexPath.row]
            cell.contentButton.addTarget(self, action: #selector(toDetailSpecialAttentionByClass), for: .touchUpInside)
        } else {
            cell.detailSubjectObj = ACData.SPECIALATTENTIONBYSUBJECTDATA[indexPath.row]
            cell.contentButton.addTarget(self, action: #selector(toDetailSpecialAttentionBySubject), for: .touchUpInside)
        }
        return cell
    }
}
