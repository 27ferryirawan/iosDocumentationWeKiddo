//
//  AbsenceListViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 30/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AbsenceListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Absent Checklist", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "AbsenceListCell", bundle: nil), forCellReuseIdentifier: "absenceListCellID")
    }
}

extension AbsenceListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACData.ABSENCELISTMODEL.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 550
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "absenceListCellID", for: indexPath) as? AbsenceListCell)!
        cell.indexObj = indexPath.row
//        cell.frame = tableView.bounds
//        cell.layoutIfNeeded()
//        cell.checkInCollectionView.reloadData()
//        cell.checkOutCollectionView.reloadData()
//        cell.checkOutCollectionHeight.constant = cell.checkOutCollectionView.collectionViewLayout.collectionViewContentSize.height
//        cell.checkInCollectionHeight.constant = cell.checkInCollectionView.collectionViewLayout.collectionViewContentSize.height
        cell.detailObj = ACData.ABSENCELISTMODEL[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension AbsenceListViewController: AbsenceListCellDelegate {
    func toDetailAbsence() {
        let detailAbsenceVC = AbsenceDetailViewController()
        self.navigationController?.pushViewController(detailAbsenceVC, animated: true)
    }
}
