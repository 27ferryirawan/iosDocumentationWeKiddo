//
//  EBookDownloadedViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 22/03/20.
//  Copyright © 2020 PT. Absolute Connection. All rights reserved.
//

import UIKit

class EBookDownloadedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configNavigation()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Student Download", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Student Download", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "EbookDownloadedContentCell", bundle: nil), forCellReuseIdentifier: "ebookDownloadedContentCellID")
    }

}
extension EBookDownloadedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACData.COORDINATOREBOOKDOWNLOADLISTDATA.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "ebookDownloadedContentCellID", for: indexPath) as? EBookDownloadedContentCell)!
        cell.detailObj = ACData.COORDINATOREBOOKDOWNLOADLISTDATA[indexPath.row]
        if indexPath.row % 2 == 0 {
            cell.bgView.backgroundColor = .groupTableViewBackground
        } else {
            cell.bgView.backgroundColor = .white
        }
        return cell
    }
}
