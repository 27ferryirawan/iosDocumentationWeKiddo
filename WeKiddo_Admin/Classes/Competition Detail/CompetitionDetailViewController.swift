//
//  CompetitionDetailViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 24/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class CompetitionDetailViewController: UIViewController {
    
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
        tableView.register(UINib(nibName: "CompetitionDetailCell", bundle: nil), forCellReuseIdentifier: "competitionDetailCell")
    }
}

extension CompetitionDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 861
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "competitionDetailCell", for: indexPath) as? CompetitionDetailCell)!
        cell.competitionObjc = ACData.COMPETITIONDETAILDATA
        return cell
    }
}
