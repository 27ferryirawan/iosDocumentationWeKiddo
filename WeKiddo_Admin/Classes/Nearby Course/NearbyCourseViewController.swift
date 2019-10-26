//
//  NearbyCourseViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 25/10/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class NearbyCourseViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configNavigation()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Nearby Course", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Nearby Course", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "NearbyCourseHeaderCell", bundle: nil), forCellReuseIdentifier: "nearbyCourseHeaderCellID")
        tableView.register(UINib(nibName: "NearbyCourseContentCell", bundle: nil), forCellReuseIdentifier: "nearbyCourseContentCellID")
    }

}
extension NearbyCourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + ACData.NEARBYDATA.course_list.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 220 : 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "nearbyCourseHeaderCellID", for: indexPath) as? NearbyCourseHeaderCell)!
            cell.detailObj = ACData.NEARBYDATA
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "nearbyCourseContentCellID", for: indexPath) as? NearbyCourseContentCell)!
            cell.detailObj = ACData.NEARBYDATA.course_list[indexPath.row-1].course_list_data
            cell.config(index: indexPath.row)
            cell.delegate = self
            return cell
        }
    }
}

extension NearbyCourseViewController: NearbyCourseHeaderCellDelegate, NearbyCourseContentCellDelegate {
    func toSessionDetail() {
        
    }
    func toSeeMoreSession() {
        
    }
    func refreshData() {
        tableView.reloadData()
    }
    func goToCourseDetail() {
        let courseDetailVC = CourseDetailViewController()
        self.navigationController?.pushViewController(courseDetailVC, animated: true)
    }
}
