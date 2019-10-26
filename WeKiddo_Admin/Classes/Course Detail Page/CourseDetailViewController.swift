//
//  CourseDetailViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 26/10/19.
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
        backStyleNavigationController(pageTitle: "Course Detail", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "CourseDetailCell", bundle: nil), forCellReuseIdentifier: "courseDetailCell")
        tableView.register(UINib(nibName: "CourseDetailListCell", bundle: nil), forCellReuseIdentifier: "courseDetailListCell")
        tableView.register(UINib(nibName: "CourseDetailFooterCell", bundle: nil), forCellReuseIdentifier: "courseDetailFooterCell")
        tableView.register(UINib(nibName: "CourseDetailRatingCell", bundle: nil), forCellReuseIdentifier: "courseDetailRatingCellID")
    }
}

extension CourseDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + ACData.COURSEDETAILDATA.course_list.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 460
        } else if indexPath.row == 1 + ACData.COURSEDETAILDATA.course_list.count {
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
        } else if indexPath.row == 1 + ACData.COURSEDETAILDATA.course_list.count {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "courseDetailFooterCell", for: indexPath) as? CourseDetailFooterCell)!
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "courseDetailListCell", for: indexPath) as? CourseDetailListCell)!
            cell.detailObj = ACData.COURSEDETAILDATA.course_list[indexPath.row-1]
            return cell
        }
    }
}

extension CourseDetailViewController: CourseDetailFooterCellDelegate {
    func toRegister() {
//        let registerVC = CourseRegistrationViewController()
//        registerVC.isFromCourse = true
//        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}
