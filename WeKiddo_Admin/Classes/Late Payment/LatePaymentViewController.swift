//
//  LatePaymentViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 16/06/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class LatePaymentViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        fetchData()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if (self != self.navigationController?.viewControllers[0]) {
            backStyleNavigationController(pageTitle: "Late Payment", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "")
        } else {
            backStyleNavigationController(pageTitle: "Late Payment", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
        }
    }
    func fetchData() {
        ACData.LATEPAYMENTLISTDATA.removeAll()
        ACRequest.POST_LATE_PAYMENT_LIST(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
            ACData.LATEPAYMENTLISTDATA = jsonDatas
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "LatePaymentContentCell", bundle: nil), forCellReuseIdentifier: "latePaymentContentCellID")
        addButton.addTarget(self, action: #selector(addPaymentAction), for: .touchUpInside)
    }
    @objc func addPaymentAction() {
        let addPaymentVC = AddLatePaymentViewController()
        self.navigationController?.pushViewController(addPaymentVC, animated: true)
    }
}

extension LatePaymentViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACData.LATEPAYMENTLISTDATA.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "latePaymentContentCellID", for: indexPath) as? LatePaymentContentCell)!
        cell.detailObj = ACData.LATEPAYMENTLISTDATA[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension LatePaymentViewController: LatePaymentContentCellDelegate {
    func toDetailLatePayment() {
        let detailVC = LatePaymentDetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
