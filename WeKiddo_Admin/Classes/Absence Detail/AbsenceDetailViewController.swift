//
//  AbsenceDetailViewController.swift
//  WeKiddo_Admin
//
//  Created by zein rezky chandra on 30/08/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

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
        return 405
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "absenceDetailCellID", for: indexPath) as? AbsenceDetailCell)!
        cell.detailAbsence = ACData.ABSENCEDETAILMODEL
        cell.delegate = self
        return cell
    }
}

extension AbsenceDetailViewController: AbsenceDetailCellDelegate {
    func confirmProcees() {
        isConfirmationViewDisplayed = true
        updateView()
    }
}
