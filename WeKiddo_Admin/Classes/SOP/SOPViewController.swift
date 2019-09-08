//
//  SOPViewController.swift
//  WeKiddo_Admin
//
//  Created by Ferry Irawan on 08/09/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD
class SOPViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configNavigation()
        fetchData()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if self == self.navigationController?.viewControllers[0] {
            backStyleNavigationController(pageTitle: "SOP", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "SOP", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "SOPCell", bundle: nil), forCellReuseIdentifier: "sOPCell")
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    func fetchData(){
        ACData.SOPLISTDATA.removeAll()
        ACRequest.POST_GET_SOP_LIST(user_id: ACData.LOGINDATA.userID, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (sopList) in
            ACData.SOPLISTDATA = sopList
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (status) in
            SVProgressHUD.dismiss()
        }
    }
}
extension SOPViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACData.SOPLISTDATA.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "sOPCell", for: indexPath) as? SOPCell)!
        cell.sopObjc = ACData.SOPLISTDATA[indexPath.row]
        cell.delegate = self
        return cell
    }
}
extension SOPViewController:SOPCellDelegate{
    func toDetail() {
        let sopDetailVC = SOPDetailViewController()
        self.navigationController?.pushViewController(sopDetailVC, animated: true)
    }
}
