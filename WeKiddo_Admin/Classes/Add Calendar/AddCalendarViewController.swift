//
//  AddCalendarViewController.swift
//  WeKiddoLogo-School
//
//  Created by Ferry Irawan on 09/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class AddCalendarViewController: UIViewController {

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
            backStyleNavigationController(pageTitle: "User Schedule", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        }
        else{
            backStyleNavigationController(pageTitle: "Agency", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
        //        setStatusBarColor()
    }
    
    func configTable() {
        tableView.register(UINib(nibName: "AddCalendarCell", bundle: nil), forCellReuseIdentifier: "addCalendarCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension AddCalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 512
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "addCalendarCell", for: indexPath) as? AddCalendarCell)!
        return cell
    }
}
