//
//  SpecialAttentionDetailByClassViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 05/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class SpecialAttentionDetailByClassViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var specialAttentionArray = 0
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
        tableView.register(UINib(nibName: "SpecialAttentionByClassDetailHeaderCell", bundle: nil), forCellReuseIdentifier: "specialAttentionByClassDetailHeaderCellID")
        tableView.register(UINib(nibName: "SpecialAttentionDetailByClassContentCell", bundle: nil), forCellReuseIdentifier: "specialAttentionDetailByClassContentCellID")
    }
}

extension SpecialAttentionDetailByClassViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + specialAttentionArray
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 110
        } else {
            return 44
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "specialAttentionByClassDetailHeaderCellID", for: indexPath) as? SpecialAttentionByClassDetailHeaderCell)!
            cell.detailObj = ACData.SPECIALATTENTIONBYCLASSDETAILDATA
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "specialAttentionDetailByClassContentCellID", for: indexPath) as? SpecialAttentionDetailByClassContentCell)!
            cell.detailObj = ACData.SPECIALATTENTIONBYCLASSDETAILDATA.score_list[indexPath.row - 1]
            return cell
        }
    }
}
