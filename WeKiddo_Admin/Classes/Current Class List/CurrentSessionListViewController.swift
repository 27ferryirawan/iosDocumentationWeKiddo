//
//  CurrentSessionListViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 17/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class CurrentSessionListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var currentSessionCount = 0
    var currentStudentAbsentCount = 2
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        populateData()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Current Session", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func populateData() {
        currentSessionCount = ACData.CURRENTCLASSLISTDATA.sessionData.count
    }
    func configTable() {
        tableView.register(UINib(nibName: "CurrentClassListHeaderCell", bundle: nil), forCellReuseIdentifier: "currentClassListHeaderCellID")
        tableView.register(UINib(nibName: "CurrentClassStudentCell", bundle: nil), forCellReuseIdentifier: "currentClassStudentCellID")
        let headerNib = UINib.init(nibName: "CurrentClassHeaderView", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "CurrentClassHeaderView")
    }
}

extension CurrentSessionListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return currentSessionCount
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ACData.CURRENTCLASSLISTDATA.sessionData[section].students.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CurrentClassHeaderView") as! CurrentClassHeaderView
        headerView.bgView.backgroundColor = .white
        headerView.bgView.setBorderShadow(color: UIColor.lightGray, shadowRadius: 2.0, shadowOpactiy: 1.0, shadowOffsetWidth: 2, shadowOffsetHeight: 2)
        
        if section == 0 {
            headerView.dateLabel.isHidden = false
            headerView.dateLabel.text = ACData.CURRENTCLASSLISTDATA.sessionData[section].dateForHuman
        } else {
            if ACData.CURRENTCLASSLISTDATA.sessionData[section].dateForHuman != ACData.CURRENTCLASSLISTDATA.sessionData[section-1].dateForHuman {
                headerView.dateLabel.isHidden = false
                headerView.dateLabel.text = ACData.CURRENTCLASSLISTDATA.sessionData[section].dateForHuman
            } else {
                headerView.dateLabel.isHidden = true
            }
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "currentClassStudentCellID", for: indexPath) as? CurrentClassStudentCell)!
        cell.studentObj = ACData.CURRENTCLASSLISTDATA.sessionData[indexPath.section].students[indexPath.row]
        return cell
    }
}
