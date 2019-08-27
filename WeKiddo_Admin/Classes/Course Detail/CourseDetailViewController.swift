//
//  CourseDetailViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 24/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class CourseDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "")
    }
    func configTable() {
        tableView.register(UINib(nibName: "CourseDetailCell", bundle: nil), forCellReuseIdentifier: "courseDetailCell")
        tableView.register(UINib(nibName: "CourseDetailListCell", bundle: nil), forCellReuseIdentifier: "courseDetailListCell")
        tableView.register(UINib(nibName: "CourseDetailFooterCell", bundle: nil), forCellReuseIdentifier: "courseDetailFooterCell")
    }
}

extension CourseDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 460
        } else if indexPath.row == 1 + 2 {
            return 552
        } else {
            return 163 // 
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "courseDetailCell", for: indexPath) as? CourseDetailCell)!
            cell.courseObj = ACData.COURSEDETAILDATA
            return cell
        } else if indexPath.row == 1 + 2 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "courseDetailFooterCell", for: indexPath) as? CourseDetailFooterCell)!
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "courseDetailListCell", for: indexPath) as? CourseDetailListCell)!
            return cell
        }
    }
}
