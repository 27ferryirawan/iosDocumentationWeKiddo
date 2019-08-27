//
//  AgencyViewController.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 02/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AgencyViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configNavigation()
        // Do any additional setup after loading the view.
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "Agency", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        }
        else{
            backStyleNavigationController(pageTitle: "Agency", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
        //        setStatusBarColor()
    }
    
    func configTable() {
        tableView.register(UINib(nibName: "AgencyCell", bundle: nil), forCellReuseIdentifier: "agencyCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension AgencyViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACData.AGENCY.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "agencyCell", for: indexPath) as? AgencyCell)!
        cell.agencyObjc = ACData.AGENCY[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailVC = NotificationDetailViewController()
//        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

