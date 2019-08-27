//
//  QuestionsViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 05/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    
    func configNavigation() {
        detectAdaptiveClass()
        if (self != self.navigationController?.viewControllers[0]) {
            backStyleNavigationController(pageTitle: "Question", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Question", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        }
    }
    
    func configTable() {
        tableView.register(UINib(nibName: "QuestionContentCell", bundle: nil), forCellReuseIdentifier: "questionContentCell")
        tableView.register(UINib(nibName: "QuestionAddNewCell", bundle: nil), forCellReuseIdentifier: "questionAddNewCell")
        tableView.register(UINib(nibName: "QuestionSectionCell", bundle: nil), forCellReuseIdentifier: "questionSectionCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension QuestionsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 35
        }
        else if indexPath.row > 0 && indexPath.row < 5{
            return 152
        }
        else if indexPath.row == 5 { //last index
            return 132
        }
        else{
            return 68
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = (tableView.dequeueReusableCell(withIdentifier: "questionSectionCell", for: indexPath) as? QuestionSectionCell)!
            return cell
        }
        else if indexPath.row > 0 && indexPath.row < 6{
            let cell = (tableView.dequeueReusableCell(withIdentifier: "questionContentCell", for: indexPath) as? QuestionContentCell)!
            if indexPath.row == 5{ //last index
                cell.dividerView.isHidden = true
            }
            return cell
        }
        else{
            let cell = (tableView.dequeueReusableCell(withIdentifier: "questionAddNewCell", for: indexPath) as? QuestionAddNewCell)!
            return cell
        }
    }
}
