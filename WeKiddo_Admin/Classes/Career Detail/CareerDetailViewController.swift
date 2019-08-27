//
//  CareerDetailViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 23/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class CareerDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Career Detail", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "")
    }
    func configTable() {
        tableView.register(UINib(nibName: "CareerDetailCell", bundle: nil), forCellReuseIdentifier: "careerDetailCell")
    }
}

extension CareerDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1091
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "careerDetailCell", for: indexPath) as? CareerDetailCell)!
        cell.delegate = self
        cell.config()
        return cell
    }
}

extension CareerDetailViewController: CareerDetailDelegate {
    func goToUniversityList() {
        let universityVC = UniversityListViewController()
        self.navigationController?.pushViewController(universityVC, animated: true)
    }
}
