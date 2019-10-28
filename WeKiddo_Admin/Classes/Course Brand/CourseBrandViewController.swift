//
//  CourseBrandViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 26/10/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class CourseBrandViewController: UIViewController {

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
        tableView.register(UINib(nibName: "CourseBrandHeaderCell", bundle: nil), forCellReuseIdentifier: "courseBrandHeaderCellID")
        tableView.register(UINib(nibName: "CourseBrandContentCell", bundle: nil), forCellReuseIdentifier: "courseBrandContentCellID")
    }

}
extension CourseBrandViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + ACData.COURSEBRANDDATA.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 220 : 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "courseBrandHeaderCellID", for: indexPath) as? CourseBrandHeaderCell)!
            cell.detailObj = ACData.NEARBYDATA
            cell.delegate = self
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "courseBrandContentCellID", for: indexPath) as? CourseBrandContentCell)!
            cell.detailObj = ACData.COURSEBRANDDATA[indexPath.row-1].subjectList
            cell.config(index: indexPath.row)
            cell.delegate = self
            return cell
        }
    }
}

extension CourseBrandViewController: CourseBrandHeaderCellDelegate, CourseBrandContentCellDelegate {
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
    func goToMore() {
        let moreVC = MoreCoursesViewController()
        self.navigationController?.pushViewController(moreVC, animated: true)
    }
}
