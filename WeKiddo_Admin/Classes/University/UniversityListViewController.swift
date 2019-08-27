//
//  UniversityListViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 23/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class UniversityListViewController: UIViewController {

    @IBOutlet weak var regionButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Top University", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "")
    }
    func configTable() {
        tableView.register(UINib(nibName: "UniversityCell", bundle: nil), forCellReuseIdentifier: "universityCell")
    }
}

extension UniversityListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACData.UNIVERSITYDATA.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "universityCell", for: indexPath) as? UniversityCell)!
        cell.delegate = self
        cell.cellDataSet(index: indexPath.row)
        return cell
    }
}

extension UniversityListViewController: UniversityListDelegate {
    func goToDetail() {
        let detailVC = UniversityDetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    func openPreview() {
        // TODO: Open to preview university, get data from API.
    }
}
