//
//  LatePaymentDetailViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 17/07/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class LatePaymentDetailViewController: UIViewController {

    @IBOutlet weak var yesConfirmButton: UIButton!
    @IBOutlet weak var closeConfirmViewButton: UIButton!
    @IBOutlet weak var confirmView: UIView!
    @IBOutlet weak var tableView: UITableView!
    private var isConfirmDisplayed = false
    private var reason = ""
    private var paymentID = ""
    private var paymentDate = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        updateView()
    }
    func configNavigation() {
        detectAdaptiveClass()
        if ACData.LATEPAYMENTDETAILDATA.status {
            backStyleNavigationController(pageTitle: "Paid", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        } else {
            backStyleNavigationController(pageTitle: "Not Paid", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
        }
    }
    func configTable() {
        tableView.register(UINib(nibName: "LatePaymentDetailCell", bundle: nil), forCellReuseIdentifier: "latePaymentDetailCellID")
        closeConfirmViewButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        yesConfirmButton.addTarget(self, action: #selector(confirmProgress), for: .touchUpInside)
    }
    @objc func closeView() {
        isConfirmDisplayed = false
        updateView()
    }
    @objc func confirmProgress() {
        ACRequest.POST_UPDATE_PAYMENT_DETAIL(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, childPaymentID: paymentID, paymentDate: "withDate", paymentNotes: reason, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (status) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: status)
            self.isConfirmDisplayed = false
            self.title = "Paid"
            self.updateView()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
    func updateView() {
        if isConfirmDisplayed {
            confirmView.isHidden = false
            isConfirmDisplayed = false
        } else {
            confirmView.isHidden = true
            isConfirmDisplayed = true
        }
    }
}

extension LatePaymentDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 511
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "latePaymentDetailCellID", for: indexPath) as? LatePaymentDetailCell)!
        cell.detailObj = ACData.LATEPAYMENTDETAILDATA
        cell.delegate = self
        return cell
    }
}

extension LatePaymentDetailViewController: LatePaymentDetailCellDelegate {
    func setPaid(withDate: String, withNotes: String, withPaymentID: String) {
        paymentID = withPaymentID
        isConfirmDisplayed = true
        updateView()
    }
    func reasonFilled(reason: String) {
        self.reason = reason
    }
}
