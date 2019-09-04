 //
//  HistoryViewController.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 31/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var countData = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        fetchData()
    }
    
    func fetchData(){
        ACRequest.POST_HISTORY_LIST(userId: ACData.LOGINDATA.userID, page: 1, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (historyData) in
            ACData.HISTORYLIST = historyData
            self.countData = ACData.HISTORYLIST.dataObj.count
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            }))
            self.present(alert, animated: true)
        }
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "History", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "History", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "HistoryListCell", bundle: nil), forCellReuseIdentifier: "historyListCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}
 extension HistoryViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("testttt \(countData)")
        return countData - 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "historyListCell", for: indexPath) as? HistoryListCell)!
        cell.historyObjc = ACData.HISTORYLIST.dataObj[indexPath.row+1]
        return cell
    }
    
    
 }
