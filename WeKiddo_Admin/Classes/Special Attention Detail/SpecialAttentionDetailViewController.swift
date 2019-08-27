//
//  SpecialAttentionDetailViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 30/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SpecialAttentionDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var specialAttentionArray = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Failed Score Detail", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "SpecialAttentionDetailHeaderCell", bundle: nil), forCellReuseIdentifier: "specialAttentionDetailHeaderCellID")
        tableView.register(UINib(nibName: "SpecialAttentionDetailSectionCell", bundle: nil), forCellReuseIdentifier: "specialAttentionDetailSectionCellID")
        tableView.register(UINib(nibName: "SpecialAttentionDetailContentCell", bundle: nil), forCellReuseIdentifier: "specialAttentionDetailContentCellID")
    }
}

extension SpecialAttentionDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + specialAttentionArray
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        } else {
            return 44
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "specialAttentionDetailHeaderCellID", for: indexPath) as? SpecialAttentionDetailHeaderCell)!
            cell.detailObj = ACData.SPECIALATTENTIONBYSUBJECTDETAILDATA
            return cell
        } else if indexPath.row == 1 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "specialAttentionDetailSectionCellID", for: indexPath) as? SpecialAttentionDetailSectionCell)!
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "specialAttentionDetailContentCellID", for: indexPath) as? SpecialAttentionDetailContentCell)!
            cell.detailObj = ACData.SPECIALATTENTIONBYSUBJECTDETAILDATA.score_list[indexPath.row-2]
            return cell
        }
    }
}
