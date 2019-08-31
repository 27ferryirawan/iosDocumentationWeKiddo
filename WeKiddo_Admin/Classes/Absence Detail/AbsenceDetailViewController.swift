//
//  AbsenceDetailViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 30/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class AbsenceDetailViewController: UIViewController {

    @IBOutlet weak var submitConfirmationButton: UIButton!
    @IBOutlet weak var closeConfirmationButton: UIButton!
    @IBOutlet weak var checkInConfirmationView: UIView! {
        didSet {
            checkInConfirmationView.layer.cornerRadius = 5.0
            checkInConfirmationView.layer.borderWidth = 1.0
            checkInConfirmationView.layer.borderColor = UIColor.lightGray.cgColor
            checkInConfirmationView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var tableView: UITableView!
    var childID = ""
    var absenceTime = ""
    var statusAbsence = 0
    var reasonID = ""
    var reasonDesc = ""
    var isConfirmationViewDisplayed = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        updateView()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Permission Request", isLeftLogoHide: "ic_arrow_left", isLeftSecondLogoHide: "ic_logo_wekiddo")
    }
    func configTable() {
        tableView.register(UINib(nibName: "AbsenceDetailCell", bundle: nil), forCellReuseIdentifier: "absenceDetailCellID")
        closeConfirmationButton.addTarget(self, action: #selector(closeConfirmView), for: .touchUpInside)
        submitConfirmationButton.addTarget(self, action: #selector(submitConfirmationAction), for: .touchUpInside)
    }
    func updateView() {
        if isConfirmationViewDisplayed {
            checkInConfirmationView.isHidden = false
        } else {
            checkInConfirmationView.isHidden = true
        }
    }
    @objc func closeConfirmView() {
        isConfirmationViewDisplayed = false
        updateView()
    }
    @objc func submitConfirmationAction() {
        ACRequest.POST_SAVE_ABSENCE(userId: ACData.LOGINDATA.userID, childID: childID, schoolID: ACData.DASHBOARDDATA.home_profile_school_id, yearID: ACData.DASHBOARDDATA.home_profile_year_id, absenceTime: absenceTime, statusAbsence: statusAbsence, reason: reasonID, desc: reasonDesc, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (result) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: result)
//            isConfirmationViewDisplayed = true
//            updateView()
        }) { (message) in
            SVProgressHUD.dismiss()
            ACAlert.show(message: message)
        }
    }
}

extension AbsenceDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 415
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "absenceDetailCellID", for: indexPath) as? AbsenceDetailCell)!
        cell.detailAbsence = ACData.ABSENCEDETAILMODEL
        cell.delegate = self
        return cell
    }
}

extension AbsenceDetailViewController: AbsenceDetailCellDelegate {
    func confirmProcees(withChildID: String, withAbsenceTime: String, withStatusAbsence: Int, withReason: String, withDesc: String) {
        childID = withChildID
        absenceTime = withAbsenceTime
        statusAbsence = withStatusAbsence
        reasonID = withReason
        reasonDesc = withDesc
        isConfirmationViewDisplayed = true
        updateView()
    }
}
