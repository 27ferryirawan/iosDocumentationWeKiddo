//
//  HomeViewController.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 11/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
    }
    func configNavigation() {
        detectAdaptiveClass()
        backStyleNavigationController(pageTitle: "Dashboard", isLeftLogoHide: "ic_logo_wekiddo", isLeftSecondLogoHide: "")
    }
    func configTable() {
        tableView.register(UINib(nibName: "HomeEventCell", bundle: nil), forCellReuseIdentifier: "homeEventCellID")
        tableView.register(UINib(nibName: "HomeEventSectionCell", bundle: nil), forCellReuseIdentifier: "homeEventSectionCellID")
        tableView.register(UINib(nibName: "HomeButtonCell", bundle: nil), forCellReuseIdentifier: "homeButtonCellID")
        tableView.register(UINib(nibName: "HomeLatePaymentCell", bundle: nil), forCellReuseIdentifier: "homeLatePaymentCellID")
        tableView.register(UINib(nibName: "HomePermissionCell", bundle: nil), forCellReuseIdentifier: "homePermissionCellID")
        tableView.register(UINib(nibName: "HomeAdminHeaderCell", bundle: nil), forCellReuseIdentifier: "homeAdminHeaderCellID")
        tableView.register(UINib(nibName: "FooterContentCell", bundle: nil), forCellReuseIdentifier: "footerContentCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ACData.DASHBOARDDATA.dashboardEventMonitoring.count != 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count != 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count != 0 {
            return 8 + ACData.DASHBOARDDATA.dashboardEventMonitoring.count + ACData.DASHBOARDDATA.dashboardEventLatePayment.count + ACData.DASHBOARDDATA.dashboardPermissionRequest.count
        } else if ACData.DASHBOARDDATA.dashboardEventMonitoring.count != 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count != 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count == 0 {
            return 6 + ACData.DASHBOARDDATA.dashboardEventMonitoring.count + ACData.DASHBOARDDATA.dashboardEventLatePayment.count
        } else if ACData.DASHBOARDDATA.dashboardEventMonitoring.count != 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count == 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count == 0 {
            return 4 + ACData.DASHBOARDDATA.dashboardEventMonitoring.count
        } else if ACData.DASHBOARDDATA.dashboardEventMonitoring.count == 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count != 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count == 0 {
            return 4 + ACData.DASHBOARDDATA.dashboardEventLatePayment.count
        } else if ACData.DASHBOARDDATA.dashboardEventMonitoring.count != 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count == 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count != 0 {
            return 6 + ACData.DASHBOARDDATA.dashboardEventMonitoring.count + ACData.DASHBOARDDATA.dashboardPermissionRequest.count
        } else if ACData.DASHBOARDDATA.dashboardEventMonitoring.count == 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count != 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count != 0 {
            return 6 + ACData.DASHBOARDDATA.dashboardEventLatePayment.count + ACData.DASHBOARDDATA.dashboardPermissionRequest.count
        } else if ACData.DASHBOARDDATA.dashboardEventMonitoring.count == 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count == 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count != 0 {
            return 4 + ACData.DASHBOARDDATA.dashboardPermissionRequest.count
        } else {
            return 2
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if ACData.DASHBOARDDATA.dashboardEventMonitoring.count != 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count != 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count != 0 {
            if indexPath.row == 0 {
                return 120
            } else if indexPath.row == 1 {
                return 33
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 2 {
                return 77
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 2 {
                return 55
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 3 {
                return 33
            } else if indexPath.row > ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 3 && indexPath.row < ACData.DASHBOARDDATA.dashboardEventMonitoring.count + ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 4 {
                return 77
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 4 {
                return 55
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 5 {
                return 33
            } else if indexPath.row > ACData.DASHBOARDDATA.dashboardEventMonitoring.count + ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 5 && indexPath.row < ACData.DASHBOARDDATA.dashboardEventMonitoring.count + ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 6 + ACData.DASHBOARDDATA.dashboardPermissionRequest.count {
                return 77
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + ACData.DASHBOARDDATA.dashboardEventLatePayment.count + ACData.DASHBOARDDATA.dashboardPermissionRequest.count + 6 {
                return 55
            } else {
                return 228
            }
        } else if ACData.DASHBOARDDATA.dashboardEventMonitoring.count != 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count != 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count == 0 {
            if indexPath.row == 0 {
                return 120
            } else if indexPath.row == 1 {
                return 33
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 2 {
                return 77
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 2 {
                return 55
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 3 {
                return 33
            } else if indexPath.row > ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 3 && indexPath.row < ACData.DASHBOARDDATA.dashboardEventLatePayment.count + ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 4 {
                return 77
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 4 {
                return 55
            } else {
                return 228
            }
        } else if ACData.DASHBOARDDATA.dashboardEventMonitoring.count != 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count == 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count == 0 {
            if indexPath.row == 0 {
                return 120
            } else if indexPath.row == 1 {
                return 33
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 2 {
                return 77
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 2 {
                return 55
            } else {
                return 228
            }
        } else if ACData.DASHBOARDDATA.dashboardEventMonitoring.count == 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count != 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count == 0 {
            if indexPath.row == 0 {
                return 120
            } else if indexPath.row == 1 {
                return 33
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 2 {
                return 77
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 2 {
                return 55
            } else {
                return 228
            }
        } else if ACData.DASHBOARDDATA.dashboardEventMonitoring.count != 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count == 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count != 0 {
            if indexPath.row == 0 {
                return 120
            } else if indexPath.row == 1 {
                return 33
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 2 {
                return 77
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 2 {
                return 55
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 3 {
                return 33
            } else if indexPath.row > ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 3 && indexPath.row < ACData.DASHBOARDDATA.dashboardPermissionRequest.count + ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 4 {
                return 77
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + ACData.DASHBOARDDATA.dashboardPermissionRequest.count + 4 {
                return 55
            } else {
                return 228
            }
        } else if ACData.DASHBOARDDATA.dashboardEventMonitoring.count == 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count != 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count != 0 {
            if indexPath.row == 0 {
                return 120
            } else if indexPath.row == 1 {
                return 33
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 2 {
                return 77
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 2 {
                return 55
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 3 {
                return 33
            } else if indexPath.row > ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 3 && indexPath.row < ACData.DASHBOARDDATA.dashboardPermissionRequest.count + ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 4 {
                return 77
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventLatePayment.count + ACData.DASHBOARDDATA.dashboardPermissionRequest.count + 4 {
                return 55
            } else {
                return 228
            }
        } else if ACData.DASHBOARDDATA.dashboardEventMonitoring.count == 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count == 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count != 0 {
            if indexPath.row == 0 {
                return 120
            } else if indexPath.row == 1 {
                return 33
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardPermissionRequest.count + 2 {
                return 77
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardPermissionRequest.count + 2 {
                return 55
            } else {
                return 228
            }
        } else {
            if indexPath.row == 0 {
                return 120
            } else {
                return 228
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ACData.DASHBOARDDATA.dashboardEventMonitoring.count != 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count != 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count != 0 {
            if indexPath.row == 0 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeAdminHeaderCellID", for: indexPath) as? HomeAdminHeaderCell)!
                cell.detailObj = ACData.DASHBOARDDATA
                return cell
            } else if indexPath.row == 1 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeEventSectionCellID", for: indexPath) as? HomeEventSectionCell)!
                cell.cellConfig(isEvent: true, isLatePayment: false, isPermission: false)
                return cell
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeEventCellID", for: indexPath) as? HomeEventCell)!
                cell.eventObj = ACData.DASHBOARDDATA.dashboardEventMonitoring[indexPath.row - 2]
                cell.delegate = self
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeButtonCellID", for: indexPath) as? HomeButtonCell)!
                cell.delegate = self
                cell.buttonSection.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
                cell.buttonSection.tag = 0
                cell.cellConfig(isEvent: true, isLatePayment: false, isPermission: false)
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 3 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeEventSectionCellID", for: indexPath) as? HomeEventSectionCell)!
                cell.cellConfig(isEvent: false, isLatePayment: true, isPermission: false)
                return cell
            } else if indexPath.row > ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 3 && indexPath.row < ACData.DASHBOARDDATA.dashboardEventMonitoring.count + ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 4 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeLatePaymentCellID", for: indexPath) as? HomeLatePaymentCell)!
                cell.detailObj = ACData.DASHBOARDDATA.dashboardEventLatePayment[indexPath.row - (ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 4)]
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 4 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeButtonCellID", for: indexPath) as? HomeButtonCell)!
                cell.delegate = self
                cell.cellConfig(isEvent: false, isLatePayment: true, isPermission: false)
                cell.buttonSection.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
                cell.buttonSection.tag = 1
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 5 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeEventSectionCellID", for: indexPath) as? HomeEventSectionCell)!
                cell.cellConfig(isEvent: false, isLatePayment: false, isPermission: true)
                return cell
            } else if indexPath.row > ACData.DASHBOARDDATA.dashboardEventMonitoring.count + ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 5 && indexPath.row < ACData.DASHBOARDDATA.dashboardEventMonitoring.count + ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 6 + ACData.DASHBOARDDATA.dashboardPermissionRequest.count {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homePermissionCellID", for: indexPath) as? HomePermissionCell)!
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + ACData.DASHBOARDDATA.dashboardEventLatePayment.count + ACData.DASHBOARDDATA.dashboardPermissionRequest.count + 6 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeButtonCellID", for: indexPath) as? HomeButtonCell)!
                cell.delegate = self
                cell.cellConfig(isEvent: false, isLatePayment: false, isPermission: true)
                cell.buttonSection.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
                cell.buttonSection.tag = 2
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "footerContentCell", for: indexPath) as? FooterContentCell)!
                cell.delegate = self
                return cell
            }
        } else if ACData.DASHBOARDDATA.dashboardEventMonitoring.count != 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count != 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count == 0 {
            if indexPath.row == 0 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeAdminHeaderCellID", for: indexPath) as? HomeAdminHeaderCell)!
                cell.detailObj = ACData.DASHBOARDDATA
                return cell
            } else if indexPath.row == 1 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeEventSectionCellID", for: indexPath) as? HomeEventSectionCell)!
                cell.cellConfig(isEvent: true, isLatePayment: false, isPermission: false)
                return cell
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeEventCellID", for: indexPath) as? HomeEventCell)!
                cell.eventObj = ACData.DASHBOARDDATA.dashboardEventMonitoring[indexPath.row - 2]
                cell.delegate = self
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeButtonCellID", for: indexPath) as? HomeButtonCell)!
                cell.delegate = self
                cell.cellConfig(isEvent: true, isLatePayment: false, isPermission: false)
                cell.buttonSection.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
                cell.buttonSection.tag = 0
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 3 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeEventSectionCellID", for: indexPath) as? HomeEventSectionCell)!
                cell.cellConfig(isEvent: false, isLatePayment: true, isPermission: false)
                return cell
            } else if indexPath.row > ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 3 && indexPath.row < ACData.DASHBOARDDATA.dashboardEventLatePayment.count + ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 4 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeLatePaymentCellID", for: indexPath) as? HomeLatePaymentCell)!
                cell.detailObj = ACData.DASHBOARDDATA.dashboardEventLatePayment[indexPath.row - (ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 4)]
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 4 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeButtonCellID", for: indexPath) as? HomeButtonCell)!
                cell.delegate = self
                cell.cellConfig(isEvent: false, isLatePayment: true, isPermission: false)
                cell.buttonSection.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
                cell.buttonSection.tag = 1
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "footerContentCell", for: indexPath) as? FooterContentCell)!
                cell.delegate = self
                return cell
            }
        } else if ACData.DASHBOARDDATA.dashboardEventMonitoring.count != 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count == 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count == 0 {
            if indexPath.row == 0 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeAdminHeaderCellID", for: indexPath) as? HomeAdminHeaderCell)!
                cell.detailObj = ACData.DASHBOARDDATA
                return cell
            } else if indexPath.row == 1 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeEventSectionCellID", for: indexPath) as? HomeEventSectionCell)!
                cell.cellConfig(isEvent: true, isLatePayment: false, isPermission: false)
                return cell
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeEventCellID", for: indexPath) as? HomeEventCell)!
                cell.delegate = self
                cell.eventObj = ACData.DASHBOARDDATA.dashboardEventMonitoring[indexPath.row - 2]
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeButtonCellID", for: indexPath) as? HomeButtonCell)!
                cell.delegate = self
                cell.cellConfig(isEvent: true, isLatePayment: false, isPermission: false)
                cell.buttonSection.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
                cell.buttonSection.tag = 0
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "footerContentCell", for: indexPath) as? FooterContentCell)!
                cell.delegate = self
                return cell
            }
        } else if ACData.DASHBOARDDATA.dashboardEventMonitoring.count == 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count != 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count == 0 {
            if indexPath.row == 0 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeAdminHeaderCellID", for: indexPath) as? HomeAdminHeaderCell)!
                cell.detailObj = ACData.DASHBOARDDATA
                return cell
            } else if indexPath.row == 1 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeEventSectionCellID", for: indexPath) as? HomeEventSectionCell)!
                cell.cellConfig(isEvent: false, isLatePayment: true, isPermission: false)
                return cell
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeLatePaymentCellID", for: indexPath) as? HomeLatePaymentCell)!
                cell.detailObj = ACData.DASHBOARDDATA.dashboardEventLatePayment[indexPath.row - 2]
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeButtonCellID", for: indexPath) as? HomeButtonCell)!
                cell.delegate = self
                cell.cellConfig(isEvent: false, isLatePayment: true, isPermission: false)
                cell.buttonSection.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
                cell.buttonSection.tag = 1
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "footerContentCell", for: indexPath) as? FooterContentCell)!
                cell.delegate = self
                return cell
            }
        } else if ACData.DASHBOARDDATA.dashboardEventMonitoring.count != 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count == 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count != 0 {
            if indexPath.row == 0 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeAdminHeaderCellID", for: indexPath) as? HomeAdminHeaderCell)!
                cell.detailObj = ACData.DASHBOARDDATA
                return cell
            } else if indexPath.row == 1 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeEventSectionCellID", for: indexPath) as? HomeEventSectionCell)!
                cell.cellConfig(isEvent: true, isLatePayment: false, isPermission: false)
                return cell
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeEventCellID", for: indexPath) as? HomeEventCell)!
                cell.eventObj = ACData.DASHBOARDDATA.dashboardEventMonitoring[indexPath.row - 2]
                cell.delegate = self
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeButtonCellID", for: indexPath) as? HomeButtonCell)!
                cell.delegate = self
                cell.cellConfig(isEvent: true, isLatePayment: false, isPermission: false)
                cell.buttonSection.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
                cell.buttonSection.tag = 0
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 3 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeEventSectionCellID", for: indexPath) as? HomeEventSectionCell)!
                cell.cellConfig(isEvent: false, isLatePayment: false, isPermission: true)
                return cell
            } else if indexPath.row > ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 3 && indexPath.row < ACData.DASHBOARDDATA.dashboardPermissionRequest.count + ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 4 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homePermissionCellID", for: indexPath) as? HomePermissionCell)!
                cell.detailObj = ACData.DASHBOARDDATA.dashboardPermissionRequest[indexPath.row - (ACData.DASHBOARDDATA.dashboardEventMonitoring.count + 4)]
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventMonitoring.count + ACData.DASHBOARDDATA.dashboardPermissionRequest.count + 4 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeButtonCellID", for: indexPath) as? HomeButtonCell)!
                cell.delegate = self
                cell.cellConfig(isEvent: false, isLatePayment: false, isPermission: true)
                cell.buttonSection.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
                cell.buttonSection.tag = 2
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "footerContentCell", for: indexPath) as? FooterContentCell)!
                cell.delegate = self
                return cell
            }
        } else if ACData.DASHBOARDDATA.dashboardEventMonitoring.count == 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count != 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count != 0 {
            if indexPath.row == 0 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeAdminHeaderCellID", for: indexPath) as? HomeAdminHeaderCell)!
                cell.detailObj = ACData.DASHBOARDDATA
                return cell
            } else if indexPath.row == 1 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeEventSectionCellID", for: indexPath) as? HomeEventSectionCell)!
                cell.cellConfig(isEvent: false, isLatePayment: true, isPermission: false)
                return cell
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeLatePaymentCellID", for: indexPath) as? HomeLatePaymentCell)!
                cell.detailObj = ACData.DASHBOARDDATA.dashboardEventLatePayment[indexPath.row - 2]
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeButtonCellID", for: indexPath) as? HomeButtonCell)!
                cell.delegate = self
                cell.cellConfig(isEvent: false, isLatePayment: true, isPermission: false)
                cell.buttonSection.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
                cell.buttonSection.tag = 1
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 3 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeEventSectionCellID", for: indexPath) as? HomeEventSectionCell)!
                cell.cellConfig(isEvent: false, isLatePayment: false, isPermission: true)
                return cell
            } else if indexPath.row > ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 3 && indexPath.row < ACData.DASHBOARDDATA.dashboardPermissionRequest.count + ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 4 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homePermissionCellID", for: indexPath) as? HomePermissionCell)!
                cell.detailObj = ACData.DASHBOARDDATA.dashboardPermissionRequest[indexPath.row - (ACData.DASHBOARDDATA.dashboardEventLatePayment.count + 4)]
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardEventLatePayment.count + ACData.DASHBOARDDATA.dashboardPermissionRequest.count + 4 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeButtonCellID", for: indexPath) as? HomeButtonCell)!
                cell.delegate = self
                cell.cellConfig(isEvent: false, isLatePayment: false, isPermission: true)
                cell.buttonSection.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
                cell.buttonSection.tag = 2
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "footerContentCell", for: indexPath) as? FooterContentCell)!
                cell.delegate = self
                return cell
            }
        } else if ACData.DASHBOARDDATA.dashboardEventMonitoring.count == 0 && ACData.DASHBOARDDATA.dashboardEventLatePayment.count == 0 && ACData.DASHBOARDDATA.dashboardPermissionRequest.count != 0 {
            if indexPath.row == 0 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeAdminHeaderCellID", for: indexPath) as? HomeAdminHeaderCell)!
                cell.detailObj = ACData.DASHBOARDDATA
                return cell
            } else if indexPath.row == 1 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeEventSectionCellID", for: indexPath) as? HomeEventSectionCell)!
                cell.cellConfig(isEvent: false, isLatePayment: false, isPermission: true)
                return cell
            } else if indexPath.row > 1 && indexPath.row < ACData.DASHBOARDDATA.dashboardPermissionRequest.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homePermissionCellID", for: indexPath) as? HomePermissionCell)!
                cell.detailObj = ACData.DASHBOARDDATA.dashboardPermissionRequest[indexPath.row - 2]
                return cell
            } else if indexPath.row == ACData.DASHBOARDDATA.dashboardPermissionRequest.count + 2 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeButtonCellID", for: indexPath) as? HomeButtonCell)!
                cell.delegate = self
                cell.cellConfig(isEvent: false, isLatePayment: false, isPermission: true)
                cell.buttonSection.addTarget(self, action: #selector(toDetail), for: .touchUpInside)
                cell.buttonSection.tag = 2
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "footerContentCell", for: indexPath) as? FooterContentCell)!
                cell.delegate = self
                return cell
            }
        } else {
            if indexPath.row == 0 {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "homeAdminHeaderCellID", for: indexPath) as? HomeAdminHeaderCell)!
                cell.detailObj = ACData.DASHBOARDDATA
                return cell
            } else {
                let cell = (tableView.dequeueReusableCell(withIdentifier: "footerContentCell", for: indexPath) as? FooterContentCell)!
                cell.delegate = self
                return cell
            }
        }
    }
}

extension HomeViewController: HomeButtonCellDelegate, FooterHomeDelegate, HomeLatePaymentCellDelegate, HomeEventCellDelegate {
    func toCurrentClassList() {
        
    }
    
    func toDetailEvent() {
        let detailEvent = NotificationDetailViewController()
        self.navigationController?.pushViewController(detailEvent, animated: true)
    }
    func toLatePaymentList() {
        let lateVC = LatePaymentViewController()
        self.navigationController?.pushViewController(lateVC, animated: true)
    }
    func toDetailLatePayment() {
        
    }
    func goToNews() {
        let newsVC = NewsViewController()
        self.navigationController?.pushViewController(newsVC, animated: true)
    }
    func goToNewsDetail(urlString: String?) {
        guard let newsURL = urlString else {
            return
        }
        let newsDetailVC = NewsDetailViewController()
        newsDetailVC.stringURL = newsURL
        self.navigationController?.pushViewController(newsDetailVC, animated: true)
    }
    func toAssignmentList() {
        
    }
    func toPermissionList() {
        let permissionVC = PermissionViewController()
        self.navigationController?.pushViewController(permissionVC, animated: true)
    }
    func toDetentionList() {
        
    }
    func toEventList() {
        let adminEventListVC = AdminEventListViewController()
        self.navigationController?.pushViewController(adminEventListVC, animated: true)
    }
    func toSpecialAttentionList() {
        // TODO: DIRECT TO SPECIAL ATTENTION VIEW CONTROLLER
    }
    @objc func toDetail(_ sender: UIButton) {
        if sender.tag == 0 {
            ACRequest.POST_ADMIN_GET_MORE_EVENT(userID: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
                ACData.ADMINEVENTLISTDATA = jsonDatas
                SVProgressHUD.dismiss()
                self.toEventList()
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        } else if sender.tag == 1 {
            ACRequest.POST_LATE_PAYMENT_LIST(userId: ACData.LOGINDATA.userID, role: ACData.LOGINDATA.role, schoolID: ACData.LOGINDATA.school_id, yearID: ACData.LOGINDATA.year_id, tokenAccess: ACData.LOGINDATA.accessToken, successCompletion: { (jsonDatas) in
                ACData.LATEPAYMENTLISTDATA = jsonDatas
                SVProgressHUD.dismiss()
                self.toLatePaymentList()
            }) { (message) in
                SVProgressHUD.dismiss()
                ACAlert.show(message: message)
            }
        } else if sender.tag == 2 {
            self.toPermissionList()
        }
    }
}
